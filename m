Return-Path: <linux-spi+bounces-7746-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FCCA9B600
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 20:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFE01BA0B28
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 18:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CA828BA85;
	Thu, 24 Apr 2025 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODv49CDw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF7B20326;
	Thu, 24 Apr 2025 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518278; cv=none; b=tPWgZcq6HK6ejgbblJvV/BvO0RPlZQM4yRxdTGIXLYvUu7zyzjGpPKlSCGQ5ePAU0DhdeyvVNvOJTSfownjBeKypqnXV+uHzA3V4ucNIkX6nPBWFze0EoKDILEtvju6ElQcTRkw+HQ83a9c3H2qJzbRw09iShMI7W8NAFSqACGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518278; c=relaxed/simple;
	bh=5RAP25L7nywb72/J4oC+rYgQg3UgmwS3x7Uic0X3HBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pswS4hoDQpk1yHcdEZwpvY87xXja5aB42/vZQ/3Y4aN2vzISZ+Lvz/rqTgDe3HYYDomBXcf4Itnw2nmr/Dt2SxrbttZ0b3pgpyxIDbIi1Vbp7PH/XqnRicP1zN0NeJyPby/MOqQbWMz+RzHLsdYt5Vc/fp9Jhx4SuFSWaXptaBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODv49CDw; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso4502734a12.1;
        Thu, 24 Apr 2025 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745518274; x=1746123074; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T0rGEYL8xcAHShUYEDJuRXwYgxLh5jv3eQQMoY4AZ/M=;
        b=ODv49CDwgOcusUB1zk8B4a5GCoQw8xp5kry38cdwHWKtxqkmP309N3gDhVGrIhDzck
         Z2DQGre1Yf9UU7fSjoF8wc0ecxy4oku8FRJZ/K1bPpllUQY7JqFXjp8SCOlcsBrKT966
         4C0d2/lTHa8Dotnlc9IL3nn2PBX3ZZi1vMLYtsI1rNH15IJP0uJOarM6UY6Pkg1ne6jF
         DCB2AtWq1BXv9Kuev/uGvy3mWqqfGHuE0+f9GabmKLNae2KV9YIVWSWwl/KwvXQti3PC
         GcOsu9NOBoZEmqEbPp4vsqdemvR2EkItOkr7eQdv7K8CMaeC/L+OwstIn14v3fjIZrXi
         WhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745518274; x=1746123074;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0rGEYL8xcAHShUYEDJuRXwYgxLh5jv3eQQMoY4AZ/M=;
        b=lUOi8rzVyog5RObsDoPcuJn1eWcIUmAK/9rZf9Uy6yC6+X0N4RxaSZx1Mollj7kFuO
         kSWftTpGNa3csHKLYTqSnuL/wXJ29itwc0MmYfK/87T/pvPPQ1byjVS6Sm863/YlThzU
         XpIzEYmo2SQR4xF58fPP5/S9Al7xFUS/5P9hNbquvgc9QWLFE8+r4Coq6jNoCZo/xVN7
         ks8Syp0UK9vY87yMVHf4NcfRI8Wwgavt30wXdqTCbFfEPzxDgcU/fEv4jbqLmyKO4F4G
         KvQUNjc+s069X1hm1NvBIKcW8BcPYfyzvOdhkhZHrxv84GMZn40GQEHldxknfJHLk5Ao
         DKbA==
X-Forwarded-Encrypted: i=1; AJvYcCUNff2/iw+MuoJuUPRBkezKQIV0br/VGXvF7v6FbJDiNxZebKEE/XSDJNW0zt+VlC98tfPFh7+1UqtYCL/i@vger.kernel.org, AJvYcCVEAf8jUpq8CnA1IJvEFLFeGL7jl5lqINfH4EwpddqwdSqwXyEjHHf1Jcq3xasPBkR4oU93e+QAl/g4@vger.kernel.org, AJvYcCXiiUdb9f2UveiwV+tvhpiBz3RBFBuTsRNEoA6hICGXQZdTMuZlMkRq43DwUR6n59JVbsHldeGazoA81Wqh@vger.kernel.org
X-Gm-Message-State: AOJu0YzVY6yKVrp6kEh4xioUUJ720SY3/8VAUkA5/SRfmNuHz/UUJeaa
	5N7kjjbUsoPp9vPP7AGgQ9S7wz37UH3GjL+HOcwGaY+xXXxF4tRR
X-Gm-Gg: ASbGncsh20LWg6Wz+f+F+VLwjYMlIHdtqPj8zeZBVnSvpjGFd+oLfGnLRnpqFAVygmr
	2INiX70aOU4VzrVndqAKt3h9i7oev28rU6O1v3L+1E6ga0ms36bXtirB7I3Ib4JiBhser/jrbIf
	v4ny8GYLAHWwWtoXAjk9AfntLDS1MCWcQFLtoPaMiZSbSwhZrZQY0cM6B7VqnNwLJ015FX4b9CD
	jkQoHf6SeNhBq0ziCEVR7o9Pv9Ffh2k7LkA8s78wJIbjUzAy7tCkMNLzDvhU/eiRo+mzNtnQp0L
	SBpSk5jE1fZ+0pmOms+JZkofaCzM/73t2JXZg6byScYDbZf415Ad3Cebz9Idk/fh5LV3LA==
X-Google-Smtp-Source: AGHT+IGQmSlSNPBNOK3WSgbIcP/kR4aqhbsVeHUJLo6BKVnUP779PR0/3w1VN5vTx4zOyvyxFtBMyA==
X-Received: by 2002:a05:6402:3592:b0:5db:68bd:ab78 with SMTP id 4fb4d7f45d1cf-5f6ef1cd09dmr3484395a12.10.1745518274388;
        Thu, 24 Apr 2025 11:11:14 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5f7011fc383sm24088a12.5.2025.04.24.11.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 11:11:13 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 24 Apr 2025 20:10:59 +0200
Subject: [PATCH] spi: spi-qpic-snand: remove unused 'wlen' member of
 'struct qpic_spi_nand'
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-qpic-snand-remove-wlen-v1-1-2a7467ce2e3a@gmail.com>
X-B4-Tracking: v=1; b=H4sIALJ+CmgC/x3MQQqEMBAF0atIr6chRsVhriKzCPFHG7TVBFQQ7
 25w+RZVFyVEQaJfcVHELkkWzSg/BfnR6QCWPpussY2pbc3bKp6TOu05Yl528DFB2RuPUH1N6dp
 AOV4jgpzvuPvf9wMT5Eb3aAAAAA==
X-Change-ID: 20250424-qpic-snand-remove-wlen-c0cef3801a7f
To: Mark Brown <broonie@kernel.org>
Cc: Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, linux-spi@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The 'wlen' member of the qpic_spi_nand structure is never used in the
code so remove that.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 17eb67e19132612c4c1a84848fa6f7432b1130a8..5d364b881566d396288f7de7c23dc0ac60fc82dc 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -116,7 +116,6 @@ struct qpic_spi_nand {
 	struct nand_ecc_engine ecc_eng;
 	u8 *data_buf;
 	u8 *oob_buf;
-	u32 wlen;
 	__le32 addr1;
 	__le32 addr2;
 	__le32 cmd;

---
base-commit: 9c32cda43eb78f78c73aee4aa344b777714e259b
change-id: 20250424-qpic-snand-remove-wlen-c0cef3801a7f

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


