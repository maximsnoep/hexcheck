#include <iostream>
#include <fstream>
#include "./HexaLab/src/app.h"

int main(int argc, char** argv) {
    if (argc != 3) {
        std::cerr << "Usage: " << argv[0] << " <mesh_file_path> <output_file_path>" << std::endl;
        return 1;
    }

    std::string meshFilePath = argv[1];
    std::string outputFilePath = argv[2];

    HexaLab::App app;
    bool result = app.import_mesh(meshFilePath);
    if (!result) {
        std::cerr << "Failed to import mesh from " << meshFilePath << "." << std::endl;
        return 1;
    }

    HexaLab::MeshStats* stats = app.get_mesh_stats();
    std::ofstream outFile(outputFilePath, std::ios_base::app);
    if (!outFile) {
        std::cerr << "Failed to open output file " << outputFilePath << " for writing." << std::endl;
        return 1;
    }

    if (stats) {
        outFile << stats->vert_count << " ";
        outFile << stats->hexa_count << " ";
        outFile << stats->quality_min << " ";
        outFile << stats->quality_avg << " ";
        outFile << stats->quality_max << std::endl;
    } else {
        outFile << "Mesh statistics are not available." << std::endl;
    }
    outFile.close();

    std::cout << "Metrics written to " << outputFilePath << std::endl;
    return 0;
}
