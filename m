Return-Path: <linux-spi+bounces-9270-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3884B19CF8
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 09:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6D81782EE
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 07:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E42023BD1B;
	Mon,  4 Aug 2025 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtMaenSt"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F7223B63B;
	Mon,  4 Aug 2025 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293949; cv=none; b=HZJRjbjUglo78+bWJPfibv5HBnz9nAOsplHlH1bC82tU/3pauL6HnA6V1cTJevZG1u7oFbLKKyRFJPhnmLUM9w6iRmtQ5bME80505AM/u3XNQ+8ynSMTAxg+e0nR+4axCrKRpx39Ruig+6+4908XEN2PQhmI/RGV1NoAMiNHmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293949; c=relaxed/simple;
	bh=qu6si2MBvuWPKV70MwLcTTL5+7tw6JBmpuMGkRPsigc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sTcHxpEwvKYgH2kFLCiIn0LHMmxaezYurtzFDFUv8WVTBdcdNi0Uyd6ATsur+9m+HY7dw4tqVaFR0Nh30OOADd04uCFqjTiDAPOaS12UeRak0tqWsChhh1XLo3IL2+JxQXBX4qE/b0KUX/rTj550+u2I4Xq1zxWI1LexNPsBWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtMaenSt; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b786421e36so2314912f8f.3;
        Mon, 04 Aug 2025 00:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754293946; x=1754898746; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/y97YE4Z88r4sQq9EZmsRXsWOa4drDMwiWCqOFeRfRw=;
        b=EtMaenSt6qkEexo9s4Jl0i2O2QSoctSjMBP1JicQ4ldzF9AX9LJf1CaYgCDt3S9cjJ
         aopuPacARC8722x6YPppK+FgGZvkhxaimzdPnt93OWzSxmip9nDxJ8CuHq0NQgLhasi0
         nw3AiMcWtxPqE3lvio9lzGHfrMjkrl76Swd1hLBopFqyNZLRX+uSpxRa9nnIqxvwVJWJ
         oYESbTz/Qrscwdpw0q1CdTe6xnwDP2us5UfHOvdBR2ILfL4tf47aFANzMF492rAIxb9m
         BkOlaR7heNfG+YneCl3ywxE3D49lV5BsVsUXjnMm4j+qB6jMOIqO/5rGDrCp3GCiT+a8
         M6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754293946; x=1754898746;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/y97YE4Z88r4sQq9EZmsRXsWOa4drDMwiWCqOFeRfRw=;
        b=HUjvzYhsqayQK5QVXusFhtrLcWofUS9ZusWYg+O7VuyKsWx5HsR+Q1bEpVhK0lf4pl
         93K9jX7R7t3WMfGPdxlgwkLPaG+7lV11grpeBCHLW0UefP1k2ckFJ1L13MJ1xpM6n+dF
         Mlfpubjyyx8aPI1R/kOqg/8vlDarJG7rfLVe+JLbPsGGcfaAvZV58hFTODMy5TlA4ZL6
         RpOFpI3JJU6EqnpUY2OsK91I122xqXo3KZjP//QiJMW8G/KXm6Jn3dJnz82gUtmVZw1k
         DP4O80ELk70LSPpqZkkgPshgOGbzlW9Dx1Bbmy3igbYOIVlpF5UKjD5SvGJIW7+vOriG
         cfwA==
X-Forwarded-Encrypted: i=1; AJvYcCXj/SpAnumW8OszYsQ8VFSp05T9KoZBu2NcsLegog1iOMD5UncgGiUagdAXXoF5FhpC7Y5HGuDqzJaLZbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZLyUyFvbkkmRYT1T2yN3eOd6qQ6HvZwaugcm3+yh+5hPKjP2J
	sbg61961+EDeETtuOB7NwM7LyZsHiPWAUExwyJMMf3QUQdvqa+DLK5ujWH6lqw==
X-Gm-Gg: ASbGncvd/NTNt99I/R/MTBUAu8BQxnqopCq/npMrnzCPdoLutV7mnkujWXSn9mwhWNq
	+owup1RYRFyj9IX7p1o7FYw289WHsaS/7K8zqDCZy0MlBK6UfocUbXzSWSYjTExitQO5baskAAx
	tVNclvHfiYix+o9YBrT9c9ne5e9wYlLIh2Qre6jH8sF/zXW9gmeIfnzeycsPpDkjINXlTNQEZOP
	49iuif/aGXsenb1N8SHW/NsT5OdUlb7rCgTZM3maP2bzluN9bfz9H7wHlEVIgk+OoeI/P+d9pSW
	sJg8EhFY8w7eh7csiCxu9zbNM5HjLuW8/lRzxjhRwejG7qErQ9nBs/+HMazAmqvQsvYRuZw7Q4/
	KsOfx2SQFThYDJJAS4+Frq2H+Th0gAnCEQw5UQddjQgg7s4QMo8U=
X-Google-Smtp-Source: AGHT+IGyAEVrLxfufX2fDTueUGPVDyx/ukGxs4pigBLinabStHozhN33tpo9nqKMZsvR47SEQPUOZw==
X-Received: by 2002:a05:6000:288b:b0:3b7:92ec:68ec with SMTP id ffacd0b85a97d-3b8d947288dmr7519869f8f.14.1754293945911;
        Mon, 04 Aug 2025 00:52:25 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c47c516sm14650906f8f.62.2025.08.04.00.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 00:52:25 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 04 Aug 2025 09:52:12 +0200
Subject: [PATCH] spi: spi-qpic-snand: avoid double assignment in
 qcom_spi_probe()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-qpic-snand-double-assign-fix-v1-1-9f4970107859@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKtmkGgC/x3MSwqAMAwA0atI1gaqKH6uIi5qGzUgURsUoXh3i
 8s3i4mgFJgU+ixCoJuVd0ko8gzcamUhZJ8MpSlr05oCz4Mdqljx6Pdr2gitKi+CMz/o5so37dR
 1prKQFkeglP/9ML7vBz8Vdi1uAAAA
X-Change-ID: 20250801-qpic-snand-double-assign-fix-cf4d78b9904a
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The snandc->dev poninter is being assigned twice in the qcom_spi_probe()
function. Remove the second assignment as that uses the same pointer
value than the first one.

No functional changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 0cfa0d960fd3c245c2bbf4f5e02d0fc0b13e7696..f6acf095fe196c3f778ba1c16157fc4bf273b66d 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1541,7 +1541,6 @@ static int qcom_spi_probe(struct platform_device *pdev)
 	}
 
 	snandc->props = dev_data;
-	snandc->dev = &pdev->dev;
 
 	snandc->core_clk = devm_clk_get(dev, "core");
 	if (IS_ERR(snandc->core_clk))

---
base-commit: ffcfd071eec7973e58c4ffff7da4cb0e9ca7b667
change-id: 20250801-qpic-snand-double-assign-fix-cf4d78b9904a

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


