Return-Path: <linux-spi+bounces-7173-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC779A65653
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 16:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8414F178778
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 15:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED542505B3;
	Mon, 17 Mar 2025 15:44:28 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FDE24C667;
	Mon, 17 Mar 2025 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226268; cv=none; b=cECtLRk1hRjl0CvOsYBnOFK9+Rm4XPCFLz6BNgjQkJBMRwhRO+pV4WHzgPT4jcl051Y57P9yIYajdgzCvpPcbyWLdycNPYb3b/NyeyPfp/sxpJXIpIZLTIMZqGeRjxT1k00ZYO/OYr8SolI9rFvpmGnLJAAptUz21shCE+MEiG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226268; c=relaxed/simple;
	bh=KnmPwZPonz8hMJ2ZmfE0STnrpgQvBXeXDMZ0NetHK1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bwtfUCNzm0noR1glTAOH1OMEUPlwFYCQFjxBnCIfPX3PePbDSQUbVwLwDlmp9Fg/L8yheOvIilmmZul5P1gUfysOXQkVg7aS4YC+mCSk3PRCgJdj/c6ceXQMv8ssUrFtDOhm5qDPtfU2ezq+WowCVKUU/+gqeSN84SXybB13+pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so718607666b.0;
        Mon, 17 Mar 2025 08:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226265; x=1742831065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wu4Tx1ZJPWIifFTi2LSxfn6zGS2x4Ovj/eqL/dD7jbA=;
        b=ZglrWnV6LqgRA6d6m/519utOHtMF37ogYf+Tu4m1R0grqMUa+50kmOpQ72u3r+siS+
         PmeTMP0lqVXP2fzr077VKmJJ4+RViEuFkwX7fGOwBh8FXcl1+n+HsW0YgnMj5IWfln7G
         7QPCRR9mHwAhuCgTXwOMx+XjQrpqk1AGV5yGBi14Lv0UiTQfD5JAzek1T+Mv4H0NCZPT
         F6D0lqdc5WVrglpNhzEbWL+npADXgC/s/t3pDbj+DvbVRWCwC9YjBvrrR1aOhgZcSC+4
         xekQDrQSSPsL3lUN1/1/y9n9FolM2AOuFuqd6sDboYLX2pCY/yJ/0pak0M/IJ09WJQyp
         ZtBw==
X-Forwarded-Encrypted: i=1; AJvYcCUkfO+r0rbyMlIYqMSZeuUMam3U1YmQY8jRtzR0dgHOtxUtW4/lFTySWv+2zlzi0XZe2nOHv0UMhTOG@vger.kernel.org, AJvYcCXvCQRr/AW3Qsy1KmSIQ47dHiXDdFGYBGd2XxvDYwEZ0MXR5Npasf0maKaeNrujWcuMGUPgIejs2Afrb1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZSeUqMC2ZCzYlTBvca3Eme0XjkRuoKOnM76Az9NlteLLgqX2B
	aDZ4Vq/JqCsdbEU7vujpnjmqjt1GGpILoURtrFIMZ4r3zk6FEbA+r4JWJw==
X-Gm-Gg: ASbGnctWPaCe+PGvfteQI3TaIy6hVECPnXTlRNsLISeYI0Mlse7t1wL6hSdOwEoFUh5
	Vqy7JhpDeRWYIfZOQNGNa6b5e+DpgfkXuI6g61nLtGISIDatH7nJ33oWoL2zPCeUSfvKwaR9jCP
	3X2IgFI020vb1bJ+rpWIqMmJ7vRrIKaVrbZvgiIsgcODMxraajvY6MF8jMPk8nK4j0mM3/g9qaW
	Pk3+HzQmqHxdQXW9I1TRy2Z7MKTMhm9W4xeVYdUQWqVWtTgQ+pJqWydiDJ84XTnnB2/fEfvm08H
	Abus+Xuqed/1ay4ozPF8mtkjvdv3jisT0Nz+
X-Google-Smtp-Source: AGHT+IF+xcwfIlvZljdbNfQRt+4Wxw3YDNhCG1PLNNFJmgb7XIzzBn0XKBKv+bCq5ve72xib8nYc3A==
X-Received: by 2002:a17:907:3d8c:b0:ac2:fd70:dda4 with SMTP id a640c23a62f3a-ac330272d02mr1213168266b.19.1742226264776;
        Mon, 17 Mar 2025 08:44:24 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314aa6209sm677874866b.184.2025.03.17.08.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:44:24 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 17 Mar 2025 08:44:02 -0700
Subject: [PATCH 2/3] spi: tegra210-quad: use WARN_ON_ONCE instead of
 WARN_ON for timeouts
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-tegra-v1-2-78474efc0386@debian.org>
References: <20250317-tegra-v1-0-78474efc0386@debian.org>
In-Reply-To: <20250317-tegra-v1-0-78474efc0386@debian.org>
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rmikey@meta.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=leitao@debian.org;
 h=from:subject:message-id; bh=KnmPwZPonz8hMJ2ZmfE0STnrpgQvBXeXDMZ0NetHK1w=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn2ENTKwjEDi8uLoqKSvtLECgSBQwZnewajleHL
 CltFG22h/qJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ9hDUwAKCRA1o5Of/Hh3
 ba9yEACBzsI+EPDFnrTMOTvWGdAV6J/1I8wmT/sbR/mEmzeA4Og+DxNN2z2mrxrISoP3fXlhc4F
 iFFiwp5QRC+wdczrgNU1maVPYGNImq5lTECqmWilecGB2fS29ExK6U2POrgDDtruA0rtfPgZVcp
 hV6jEITJ4dJhdPY5XaymeTDYHNfQh/40/p95QYDGEJe1bQ++OYKfEt/GTpqT8ln6mSG8i8Xe6IS
 a6mdPdgQxzMnUsDTK5bXDNXZh7/wi9oHCuAUVSbki60b+awSRrcqLY29An5uYsP/i/fh2MwsPHJ
 S7Ts09SWc0Zbs091TzM9DeKsW85VTYkAzSC4dAaSl5L03pjKVf/cV1LwAvCucf9craMoMq4KhlZ
 uNbAdxGymuPrTp3SfPps+hZsLP6hLxRH2PT1jYNa90GCeyZLc4NY8rYy1sD5fO7evLk6UoBt9W9
 SgNBmTT8D0oyHyKS6Gr0osEHLZvTZEMU6+XpWCumu43AFYEF2gvv1K1pP3JX+lt5dAl9x5eYjlL
 kfHJL2MoQHXyDxwPMFfJh8m1xnK+U/EYBfEgG/oSH6LWOD5JmJamR5AuPy7iwxBgNXskjjTKV2Y
 WtS5uLKRWFjUgWAx1/38Usw6FOJBO7kN2Brh7jZhnu3tShofaMhshOnLQv9q++ciUOlEXFAk52A
 78v5OzCwgxEYuTQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Some machines with tegra_qspi_combined_seq_xfer hardware issues generate
excessive kernel warnings, severely polluting the logs:

    dmesg | grep -i "WARNING:.*tegra_qspi_transfer_one_message" | wc -l
    94451

This patch replaces WARN_ON with WARN_ON_ONCE for timeout conditions to
reduce log spam. The subsequent error message still prints on each
occurrence, providing sufficient information about the failure, while
the stack trace is only needed once for debugging purposes.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/spi/spi-tegra210-quad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 9027f995a6669..7c10b1272b0ad 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1117,7 +1117,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					(&tqspi->xfer_completion,
 					QSPI_DMA_TIMEOUT);
 
-			if (WARN_ON(ret == 0)) {
+			if (WARN_ON_ONCE(ret == 0)) {
 				dev_err(tqspi->dev, "QSPI Transfer failed with timeout: %d\n",
 					ret);
 				if (tqspi->is_curr_dma_xfer &&

-- 
2.47.1


