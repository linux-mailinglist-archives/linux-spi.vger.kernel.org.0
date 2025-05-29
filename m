Return-Path: <linux-spi+bounces-8336-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96478AC81B6
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 19:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66DC51BC479E
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 17:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6E222D4EF;
	Thu, 29 May 2025 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cefTW+Lw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED3B67F;
	Thu, 29 May 2025 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748540165; cv=none; b=P3uK/RCtzNnytKZ+Naf1z1wvnI5yfSfxQ9bjxJcYBsqndLpQZtsVFMjBD3gunc/vSpWQgvLEkeHPg3Lar3osHYkXtUrHGOE2GXVTkf9wikPh2lBzVpUnrHra8Ot/w5PzU8HtRsx+d4V9EP/XxMqEVZStPP39xPoiG5Jy/pX7kBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748540165; c=relaxed/simple;
	bh=ZAKNyWxhkVqG4oVpkuVC80WBXm3Gp/KiDD+hs3noY5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dJfaCi6NmVSdXijhvZFylEYa6bKSiADiTeE9ckcWv60K/59myB8OV2OBpOQLcPYDWrMzeC6JoKbHXrkzO+xE8IbThOo21/OOKr2K2AgauCP0WzjDBR95BEwxSWfZOfTq/bfnp4QRa4FqBNZ7nLtBdXGkZiBp3X4vdY9Zd1fLjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cefTW+Lw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad572ba1347so174975966b.1;
        Thu, 29 May 2025 10:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748540162; x=1749144962; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+A71to2hM6tQB6kJBFVVEwobIWwE5T+2BzX0UTpMXkU=;
        b=cefTW+LwZKYlkZCr5kdB6RZ2edGQ9k/YCkpyRhVFbywbXE+JVGZFqq82xZvNh3LdR2
         h4MerqVnh9cufl+d1p49IJIkCXfqE2Gks+yeK1a75IYKrzTEdQ8V4ZUhiPeT6fF7XPQT
         Fv4fgBO84dd7yisaT8vp7bonltptGuqvIBZJPW0T/PKQmxcfstYNte0XmU6wZP6ac5sL
         B+pDowjYeVAuvOa9QWOVwi/z7sgbYkV9kZN+YXQUZx/6I9aES1Ua/5ys5J6AqxC1WE0Y
         /cQmaVxUJ2PkVdUhTQoyhU30yY8abt7xrR4xqq8I3PtcG8xHOe/bE/fJvR8Z4wuGv87t
         WSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748540162; x=1749144962;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+A71to2hM6tQB6kJBFVVEwobIWwE5T+2BzX0UTpMXkU=;
        b=cejYH0hzMZv4DGXiPGGwUxaoaUmZJaxYQfycgB6JJznIrm69rA9lxZU/8rovGHCW+D
         /QJWY9ETl865eu/VHW4dKNdTzTmXcEKE32E10CiUn6pwS3YR7FeP0T1r4qoDr3yMDugT
         FkcJrDR9GCA6ssQEig/08I1vqnWknETR6VIg3gGX08QvE7NL9a/7z3b9TAvaEdy4lWRw
         vDjN2QI/Z4wrSaL5uXmAVxlMPAz0IRYCYJsrh/W58KzeNzP9Rpuxx73aBug4oJt8xfuj
         kFXLZAJTrbE84e01O63fpdBt0al4aetcA6S1c9FA629If7hveIZKcHURVScZr2SV3m35
         wh8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9yleQ1C0qpNvXwwywGw67watXNrD4hwAdpXDSGdGPTCYIqWDtvXE+jDNwM68uE9wz0e6lhmcq3c+5ghR7@vger.kernel.org, AJvYcCWTEjZ4IRWnxvg+UfN6Z0AGVOxi+u7ecwH2KC5spRprEMAw3nnTKqBCczGuqorVwHQUc+y8wV8PAIrc@vger.kernel.org, AJvYcCXnqVxFHiloyj9/ZDOO0BEGeCdmm8mWiwCfiKiSXY+rEnJChFSXn7I5SsWzuw6Ot20y8k6Nb+BUKjqCOLn+@vger.kernel.org
X-Gm-Message-State: AOJu0YzArSkXeiuUXLO/V4C05TZ7YePrqV9Oa7WvoGx7iiDIjy8OlWjl
	nJDF27jB/10s/H32yR3vAx5rNoCsa9msiW93YoDG1i0ghJoCrqlSYbrM
X-Gm-Gg: ASbGncslcSa9TtAGT7RugrImf3otWNFZ4EK0rqVlbAguA51RGdiKD7PCDDKTesxIorq
	31IFQh8EdE+cOuF9shofWMOmJNHBGJr9CSFnurXh+1tVXan+eC3n8mO/tjd3EC6xORbnc94llsQ
	VUjdcWgQcnx5LqlivbIbNRUtzhrcsRQ0tHkPTxOtxRdQZMaU0puWfHtz4pvIGGvHJZZ/EFIU8ZI
	TdjH28JlYrIyVSK56VtDzBw01V5IB5VOcTXSW6WrYZ9z8yA7lznsT0xIjN2270yCXuNpKz0V8l+
	O1FNx4VyXVHIBy753dw5kVKNpyp6SqKymFv1Jhu5xZchG5gN4FGqATD201d5RAajJxKBryq5Tpu
	GlEl4+zETYC3/+Mw=
X-Google-Smtp-Source: AGHT+IH//RBmm/8B7tXeJxyKxnZbF4nmP5r2kdAJ1HrNz2e0Po4vQ+YILnUKQo3DQtFXYndTTNZ3dA==
X-Received: by 2002:a17:907:3d90:b0:ad8:9b24:9d16 with SMTP id a640c23a62f3a-adb32245bd9mr34324366b.6.1748540162157;
        Thu, 29 May 2025 10:36:02 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ada6ad6ab2csm173992866b.184.2025.05.29.10.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 10:36:01 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 29 May 2025 19:35:44 +0200
Subject: [PATCH] spi: spi-qpic-snand: remove 'qpic_snand_op' structure
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-qpic-snand-remove-qpic_snand_op-v1-1-6e42b772d748@gmail.com>
X-B4-Tracking: v=1; b=H4sIAO+aOGgC/x2NQQqAIBAAvxJ7bqEsi/pKRJRutYfUFCSI/p54n
 DnMvBDIMwUYixc8RQ5sTYK6LECdqzkIWScGUQlZSdHi7VhhMKvR6OmykbJZslmsw37YNO1S6a6
 RkCrO085PPkzz9/09eksLcQAAAA==
X-Change-ID: 20250524-qpic-snand-remove-qpic_snand_op-79bdef5cd635
To: Mark Brown <broonie@kernel.org>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The 'qpic_snand_op' structure is used only in the qcom_spi_send_cmdaddr()
function as a type of a local variable. Additionally, the sole purpose of
that variable is to keep some interim values before those gets passed as
arguments for cpu_to_le32() calls.

In order to simplify the code, remove the definition of the structure
along with the local variable, and use the corresponding values directly
as parameters for cpu_to_le32() calls.

No functional changes intended.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index fd129650434f0129e24d3bdac7e7c4d5542627e6..7b6ad846829d1f2d86883f53faacb7a433a7107c 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -59,12 +59,6 @@
 #define OOB_BUF_SIZE			128
 #define ecceng_to_qspi(eng)		container_of(eng, struct qpic_spi_nand, ecc_eng)
 
-struct qpic_snand_op {
-	u32 cmd_reg;
-	u32 addr1_reg;
-	u32 addr2_reg;
-};
-
 struct snandc_read_status {
 	__le32 snandc_flash;
 	__le32 snandc_buffer;
@@ -1280,7 +1274,6 @@ static int qcom_spi_write_page(struct qcom_nand_controller *snandc,
 static int qcom_spi_send_cmdaddr(struct qcom_nand_controller *snandc,
 				 const struct spi_mem_op *op)
 {
-	struct qpic_snand_op s_op = {};
 	u32 cmd;
 	int ret, opcode;
 
@@ -1288,34 +1281,24 @@ static int qcom_spi_send_cmdaddr(struct qcom_nand_controller *snandc,
 	if (ret < 0)
 		return ret;
 
-	s_op.cmd_reg = cmd;
-	s_op.addr1_reg = op->addr.val;
-	s_op.addr2_reg = 0;
-
 	opcode = op->cmd.opcode;
 
 	switch (opcode) {
 	case SPINAND_WRITE_EN:
 		return 0;
 	case SPINAND_PROGRAM_EXECUTE:
-		s_op.addr1_reg = op->addr.val << 16;
-		s_op.addr2_reg = op->addr.val >> 16 & 0xff;
-		snandc->qspi->addr1 = cpu_to_le32(s_op.addr1_reg);
-		snandc->qspi->addr2 = cpu_to_le32(s_op.addr2_reg);
+		snandc->qspi->addr1 = cpu_to_le32(op->addr.val << 16);
+		snandc->qspi->addr2 = cpu_to_le32(op->addr.val >> 16 & 0xff);
 		snandc->qspi->cmd = cpu_to_le32(cmd);
 		return qcom_spi_program_execute(snandc, op);
 	case SPINAND_READ:
-		s_op.addr1_reg = (op->addr.val << 16);
-		s_op.addr2_reg = op->addr.val >> 16 & 0xff;
-		snandc->qspi->addr1 = cpu_to_le32(s_op.addr1_reg);
-		snandc->qspi->addr2 = cpu_to_le32(s_op.addr2_reg);
+		snandc->qspi->addr1 = cpu_to_le32(op->addr.val << 16);
+		snandc->qspi->addr2 = cpu_to_le32(op->addr.val >> 16 & 0xff);
 		snandc->qspi->cmd = cpu_to_le32(cmd);
 		return 0;
 	case SPINAND_ERASE:
-		s_op.addr2_reg = (op->addr.val >> 16) & 0xffff;
-		s_op.addr1_reg = op->addr.val;
-		snandc->qspi->addr1 = cpu_to_le32(s_op.addr1_reg << 16);
-		snandc->qspi->addr2 = cpu_to_le32(s_op.addr2_reg);
+		snandc->qspi->addr1 = cpu_to_le32(op->addr.val << 16);
+		snandc->qspi->addr2 = cpu_to_le32(op->addr.val >> 16 & 0xffff);
 		snandc->qspi->cmd = cpu_to_le32(cmd);
 		return qcom_spi_block_erase(snandc);
 	default:
@@ -1327,10 +1310,10 @@ static int qcom_spi_send_cmdaddr(struct qcom_nand_controller *snandc,
 	qcom_clear_read_regs(snandc);
 	qcom_clear_bam_transaction(snandc);
 
-	snandc->regs->cmd = cpu_to_le32(s_op.cmd_reg);
+	snandc->regs->cmd = cpu_to_le32(cmd);
 	snandc->regs->exec = cpu_to_le32(1);
-	snandc->regs->addr0 = cpu_to_le32(s_op.addr1_reg);
-	snandc->regs->addr1 = cpu_to_le32(s_op.addr2_reg);
+	snandc->regs->addr0 = cpu_to_le32(op->addr.val);
+	snandc->regs->addr1 = cpu_to_le32(0);
 
 	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 3, NAND_BAM_NEXT_SGL);
 	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);

---
base-commit: 589561cb455189154a7110a39d9fcc39965f3104
change-id: 20250524-qpic-snand-remove-qpic_snand_op-79bdef5cd635

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


