FROM shuup-master-shuup:latest  

# Copy your project files (if any)
COPY . /app

# Set environment variables (if needed)
ENV SHUUP_WORKBENCH_BASE_DIR=/app 

# Start the Shuup server
CMD ["python3","0.0.0.0:8000"]