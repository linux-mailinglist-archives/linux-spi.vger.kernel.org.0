Return-Path: <linux-spi+bounces-9090-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06B1B021DB
	for <lists+linux-spi@lfdr.de>; Fri, 11 Jul 2025 18:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A65DA7A78A4
	for <lists+linux-spi@lfdr.de>; Fri, 11 Jul 2025 16:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366992ED155;
	Fri, 11 Jul 2025 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxuNmqG4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2F415A858;
	Fri, 11 Jul 2025 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251597; cv=none; b=tNhIqQ8NtOrsosTO3Gy/SrxjRF+NmkAPO7obKo36eyuDAA0iC+H3z7kkYS8q4TiC33mVDb2wv0tIq7nm0RZ5Tj0a3K1WNZ1z2sNjhohz7BZf0gp4k7oGerM7a6t9X5asVkPLzcmDjVMyUSAjOyE8lCMpmYQ/mXfY4lmM6PYFyuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251597; c=relaxed/simple;
	bh=7USLu/Tu8CmztTr3/24FOEB2Dn4f9FhVd2eqi2tHmfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jour0LG8gvhre60CylhTVb31Uluh0eOQwvm7CFYL5qmxsyJxp4TWO+IjHsZDDXv858IatUi+Q7wT2Dwb0eQA1Ji9OHX3j4z3LhPmq2JKnYzcj+U6TVMOIkwL7uxMIa8YNUxj9cuho0n40UcBFtZVVIe9t0rBaR4ZSgOlZ/ogHdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxuNmqG4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a5257748e1so1768067f8f.2;
        Fri, 11 Jul 2025 09:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752251594; x=1752856394; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A1r7lOXR2bkUYaFtDJ7CylYLTgBc/fYyMcmc/+yJZ30=;
        b=JxuNmqG41HuQKVkjTEOY+LF6c2txrkJ1F2XAYOj6i5DEUz27lQvRFhUvB5lf2zs90f
         P5CDeqaOmIlQ1yHHopiNpaB58KLRwgQMa/ka8N2ntSXD+mhM073OLLik7YHNaRus68CS
         hyhP6U914C8btN8CB8OLo9MuRn4HcI96Lgn8/G2lJxYV6s7qTIuFk6InLwgmqr2NxWyu
         G8xOWLW+XVYNKa13MoQpumsH22OIexp9sB865EHl4pG4iFtGE0t74U6l5XARKO/f06Hd
         7snFoBjT2IhQQD73k/rd7dtD+09qnSQWWUz4qx3SexRDiF3gQGvZ04TNVwbMjZ3IvkFC
         YsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752251594; x=1752856394;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1r7lOXR2bkUYaFtDJ7CylYLTgBc/fYyMcmc/+yJZ30=;
        b=vJjHXV0VFkR2jeFvHQOmmb60SBi/aPbaNgaOS44THlrQ9hwq50yseKvcpo/irABhDY
         oEWeMg4rEvLCz9M7FFdyW/0m4IpYJaebUNlhKFGSMGyv6lZfvN6VbM2wUU0dWAXkLq/z
         80sgKr6uAU8rJkldvvyXSOXmroHIJeEav3g1OgaO/3rulFIIT4jcfApY19CkptJ8GOdj
         9PgrcZdLYnIpf9vb8qiMWS2ozXGj1Q45X6vwSJljs2dL5VEFgTkwuWPDl+gRUG+SQHXW
         u7H38HjwyddQ0mZFnys5ppwwKnMdh+z1lcgcJTDUsVOiKjbeH1we1gN7PZriHYkAqa1X
         i6OA==
X-Forwarded-Encrypted: i=1; AJvYcCV/osZ/qKWzy7zqZwW+ItaQosDcy5yTp5owQllEtDJ504Bn8I3gTfaJ1gCEpBRFTqTx1QsYDrSphkgDwfiS@vger.kernel.org, AJvYcCVZAGIJAQKNah6UBfFuEUb8pOow+41pKxKqwVHTwMbRMeIRuuxN1mITOR1yHL2MMQBK85IMI8U1sugENWMg@vger.kernel.org, AJvYcCXMdGMO2k2hzeyDj7UHvk67wkt/vcbVJIUjNZbMH/7l7MmbPCUSHkBKYlD04bOQnF4Fy/OJxLx9u8rV@vger.kernel.org
X-Gm-Message-State: AOJu0YxQeQP+FYJ0hDhJ/IAE66l8QINMgqc0IjcqCTrVHrKHay+hqSIC
	eVelkQjr0QVMHm9vylkRYRnHadVBPfsM8vgrlQbce1pDfETHeHU6CXar
X-Gm-Gg: ASbGncsERVa2T3uuvebC6vdD0WFUyQV8t+TWUgFILMce7Zg9UZ9AKNalkaxpeIB/dcj
	xEp5aU8Vdn3jY7FOA1nZYxaMSTSMEJaMDmLLMs0OcoBcbYWlqW7tzOz9q2Gnr2vjKUw+5Xs66A/
	ws4Xzw9L5wRkQrJGVxONe9pOhefHGLESYd55oIU0Ee04NeYjECHMFuTvNo40qB2w3s/8wZQJTOh
	F4ZwPRyoQdA/0D7jT2k/lCveqhvyMzKRuRj0gSN8WZ+tm4Rs7ZO8QP7G9sIYCX/7OV84sCayUTS
	Cmi+OWsYsJPD8FoS8i8HPi8Tcgqj7xudkIX1kbY1hfGOa/WWUiop58cHxAuK8VERfAEX5y8l24l
	WfOtFR3CEQDPwBzUJB71gcY/Qj4+hsb8ltpjQAo2buJ3eLOvVkb0=
X-Google-Smtp-Source: AGHT+IEZlhPktMwwW0Jbf3RqoTX/NKhZqR5TJTdFaddNSu4Crn0tbA5n062K8UspEDbchBqtVVg+fw==
X-Received: by 2002:a05:6000:40ca:b0:3a4:f786:4fa1 with SMTP id ffacd0b85a97d-3b5f2db14eamr3033408f8f.2.1752251593613;
        Fri, 11 Jul 2025 09:33:13 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d4b5sm4969860f8f.53.2025.07.11.09.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:33:13 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Fri, 11 Jul 2025 18:32:52 +0200
Subject: [PATCH] spi: spi-qpic-snand: simplify bad block marker duplication
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-qpic-snand-simplify-bbm-copy-v1-1-dd2608325f72@gmail.com>
X-B4-Tracking: v=1; b=H4sIALM8cWgC/x3MwQqDMAwA0F+RnBeIAXHsV4YHjVEDa60NDEX67
 ys7vsu7wTWbOryaG7J+zW2PFe2jAdnGuCraXA1M3FHfEh7JBD2OcUa3kD62XDhNAWVPFz5ZhJS
 IWXqoRcq62Pnv30MpP0IL7B1uAAAA
X-Change-ID: 20250710-qpic-snand-simplify-bbm-copy-82cc0e0022c7
To: Mark Brown <broonie@kernel.org>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

Due to the expectations of the SPINAND code, the driver duplicates
the bad block markers during raw OOB reads.

It has been implemented by using two if statements, and due to the
opposite conditions one of conditional codepaths always runs. Since
the effect of both codepaths is the same, remove the if statements
and use a single line solution instead.

Also add a note about why the duplication is required.

No functional changes intended.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index b711c8be42c1f76029497b0c17d00cd8e52f5aa2..94c4d76cee34420d1dc3894aadad0086c6f22d96 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -597,10 +597,16 @@ static int qcom_spi_read_last_cw(struct qcom_nand_controller *snandc,
 
 	bbpos = mtd->writesize - ecc_cfg->cw_size * (num_cw - 1);
 
-	if (snandc->data_buffer[bbpos] == 0xff)
-		snandc->data_buffer[bbpos + 1] = 0xff;
-	if (snandc->data_buffer[bbpos] != 0xff)
-		snandc->data_buffer[bbpos + 1] = snandc->data_buffer[bbpos];
+	/*
+	 * TODO: The SPINAND code expects two bad block marker bytes
+	 * at the beginning of the OOB area, but the OOB layout used by
+	 * the driver has only one. Duplicate that for now in order to
+	 * avoid certain blocks to be marked as bad.
+	 *
+	 * This can be removed once single-byte bad block marker support
+	 * gets implemented in the SPINAND code.
+	 */
+	snandc->data_buffer[bbpos + 1] = snandc->data_buffer[bbpos];
 
 	memcpy(op->data.buf.in, snandc->data_buffer + bbpos, op->data.nbytes);
 

---
base-commit: 7d61715c58a39edc5f74fc7366487726fc223530
change-id: 20250710-qpic-snand-simplify-bbm-copy-82cc0e0022c7

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


