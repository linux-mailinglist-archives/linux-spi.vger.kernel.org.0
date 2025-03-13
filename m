Return-Path: <linux-spi+bounces-7125-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76582A5FF48
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 19:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0A1422560
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277331EF0AE;
	Thu, 13 Mar 2025 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsaHEtIX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5BD1DB154;
	Thu, 13 Mar 2025 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890703; cv=none; b=KmMl8Bp5ktSVpvKqoNihu/Z9q5NYCVFebYzfqU0Pu+0ZDwAd9PE4LVv8cCJmJJUD12tqSusiDsUAT6JIa+3ZVTvwljw/uSIFUgnn4GuE76fYBE47urwaP88nSXegIFQqKinRz71oIx4tnahthLfUw9jyITlyfppiS0RcVwUcS8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890703; c=relaxed/simple;
	bh=APtOrAMu55p9anUFRahuUI9e/7uvcdKCe8tXSAK61wY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VydXhs+rOue6qQRORh08/I3YYre7otAA5v5PvSWF2l36KJZNpPm3lyE83aLbXtwCKDI5tA0TlJfKbPQA0l7XPZlAcOHs5ZGGnzf2N3XmjICfYFD7ODYr5lHIC4QFIxNwSHBnrxqRlhdeoT6EPk/hBiJRcOlZaB7I6CyiaMZE3wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsaHEtIX; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2bfcd2a66so227940066b.0;
        Thu, 13 Mar 2025 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741890700; x=1742495500; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sYVge1fJWhW6G78HzfBQJjKWAy1dCSFLRmTto5QH1Os=;
        b=CsaHEtIXJam7b4c9uXvVbi0of3F3FM4Na38WSKfY8CmbKem72BxZb+BMh60bdMDYGT
         bqvTENKXcoXPksLXubuyNoKNmYJA3uHMsugikhge3rsiY4uWQh+e4Mhheno6yww8Xe7O
         5l/QQsPioEUsq3C3ReUoxoEjrBEibu9/iRUSGXfZlazxBbjb24Xn5S0/QOFRnkzDIWUu
         HroW5ADGrI30mZlogpoOK1NnTaTwRH+TgbhQUamjm65VWyu9m5mampIOYG5nWZNxGufx
         HIws2hr0WKdsBw+QDWvA9ddv72yM0w0AGAN/1gUqmVUX3rrs9fpb52ZEIewUCEJ4r0Er
         1sRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741890700; x=1742495500;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYVge1fJWhW6G78HzfBQJjKWAy1dCSFLRmTto5QH1Os=;
        b=E1i8d8h4o9XQWyEOUIgohEmlcllYPo6CedxIChf/QOos/1ZOuTQm6kIVeb74+g/chp
         K0EMckPH8eRNccB6AAZOO70ft7Sj/dGJ3yKzIIw3c+nICkKC3/MBk7QbRDSqgqxdGZDi
         aKvwII73/MY2kkc2idxX4Hqov+PqexLhBSMQ8jw47uqjQK8K7WuI/i4PLmbCQUQhc3zL
         iwFcuyvcvdyZtVfR1aU3lGgxmxbWvtX6HxM+pubcB6h2Vr319c1/cinFsONF58J1dFiG
         PcuVqEyeUSnSeMBloTapxB3Ah2AahhID+rpLnVZrXyDu0wvV9kSI58ixOi6gwRZV38ap
         2sxA==
X-Forwarded-Encrypted: i=1; AJvYcCVwKfZQ8DnPkWIAOmJAeCxmSjnXsv8V17zlnPkcMoZBSySjrKfRMN+4vrvH27qn3UBwljvIeeCwzYKO460=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa5QTir3pQy0glwYXbtZuLRBbGWI4aYcPbEDsWq+mGe9K3lunE
	dZ2gR+UcW9sPQPQil+4a0GltOueu7s/ftkliYCDxRbZAjZii55A4
X-Gm-Gg: ASbGncsY9LhM0Yql0ZcDNKsfQblkT8rUdAdQ4OKHO70KVcsYgilfZVhWRqHnxsEdoGF
	DIKLgu8X1BTdGjtLdKDacQp5mIx51phPUzvRMBLww1+VgBOsScMDPm8WKJnBoatFTGSftJGImNR
	h6+yqaR+rtfFAOUCt/Notv+tqRlujo/p77W4FtgH6JyNJTivx/iU2PliP0YEj86D2EW6JFQ46XR
	2NUje1RgO+9cxG/zSAKcaS3bzH82M1Il6Vl2/VgChcI6E3AJZRkHUqLcDan+hwAbRg6mYz2gGgK
	U/QgEjt/BlZ01TMmzmqwzHfuh687/pbyl1A+RSlq/X7rW7tMyQGmMBOoC0OCHFWJ6bQRBs3PRw=
	=
X-Google-Smtp-Source: AGHT+IH5igbuEzQC5N8OUm5Jleti7EpnGN43pb7SHo4H5tZdYX/+X1Lsw1he29WPdx7wgQmoITksFg==
X-Received: by 2002:a17:906:be2:b0:ac2:d0e1:235a with SMTP id a640c23a62f3a-ac2d0e12ad1mr1034633666b.39.1741890699616;
        Thu, 13 Mar 2025 11:31:39 -0700 (PDT)
Received: from [169.254.110.2] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac314a3e0a1sm111573866b.140.2025.03.13.11.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 11:31:39 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 13 Mar 2025 19:31:21 +0100
Subject: [PATCH next] spi: spi-qpic-snand: avoid memleak in
 qcom_spi_ecc_init_ctx_pipelined()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-qpic-snand-memleak-fix-v1-1-e54e78d1da3a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHgk02cC/x2MQQqEMBAEvyJzdsBoFNyviIcQWx3UWU2WRRD/b
 vBYBVUXRQRBpE92UcBfonw1gckz8rPTCSxDYiqLsi4qU/Gxi+eoTgfesK1wC49ysh0NrGus8U1
 LKd4Dkn7HHSnOH/X3/QDEMb9mbgAAAA==
X-Change-ID: 20250313-qpic-snand-memleak-fix-4f1e4a641c69
To: Mark Brown <broonie@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

When the allocation of the OOB buffer fails, the
qcom_spi_ecc_init_ctx_pipelined() function returns without freeing
the memory allocated for 'ecc_cfg' thus it can cause a memory leak.

Call kfree() to free 'ecc_cfg' before returning from the function
to avoid that.

Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index ffb2b6ec685ce3e0b6c56fa38988c5de011445e7..fbba7741a9bf336deed1c07eab8d5a94204878d7 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -263,8 +263,10 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 		return -ENOMEM;
 	snandc->qspi->oob_buf = kzalloc(mtd->writesize + mtd->oobsize,
 					GFP_KERNEL);
-	if (!snandc->qspi->oob_buf)
+	if (!snandc->qspi->oob_buf) {
+		kfree(ecc_cfg);
 		return -ENOMEM;
+	}
 
 	memset(snandc->qspi->oob_buf, 0xff, mtd->writesize + mtd->oobsize);
 

---
base-commit: cce2200dacd6d7e0501c3811f24f5216710968fb
change-id: 20250313-qpic-snand-memleak-fix-4f1e4a641c69

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


