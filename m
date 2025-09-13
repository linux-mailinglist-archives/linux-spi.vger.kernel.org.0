Return-Path: <linux-spi+bounces-10005-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C0CB562E5
	for <lists+linux-spi@lfdr.de>; Sat, 13 Sep 2025 22:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F8817A475
	for <lists+linux-spi@lfdr.de>; Sat, 13 Sep 2025 20:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5335225DB1D;
	Sat, 13 Sep 2025 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkH9y2yb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ED923770A
	for <linux-spi@vger.kernel.org>; Sat, 13 Sep 2025 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757794616; cv=none; b=D1ORIJgDewDB4t/0fHuuwQwGmwFbH/zI1KpEeBa2fIY2pqssl3NOCR/4Ye52UuAJKgolWCEW9NOCgreM6zwTCjYyBeik4dDzQ7y+YuMto8d7o645IrMZTu4s/D8oK13HSbupMO+3w6W04gLU6RV2a3l91JhLyZwsQIXse1JUQi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757794616; c=relaxed/simple;
	bh=FWdFpDZXgweIgfaXmSGMrKPTFYGwmCSWLoLB9qphSGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GKbjxNuKa1HljOMePmKOSe7l/NmYjruC9oCMXrHeB+oZGPIlXL2t+a7JzCeSemCL+hGFUeEPBtEaxgd+x6advZNdzOesijWW8yWTC3rK2Dvt88uU4RlC2CZRh4fp1lnGTxv2fG13SfNKBSVyTNSE8fM1KZQKjqqHEVH0cfEVWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkH9y2yb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45deccb2c1eso23046115e9.1
        for <linux-spi@vger.kernel.org>; Sat, 13 Sep 2025 13:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757794612; x=1758399412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Koaj6pqpf5k3Jy2jPYnNq/imDVBkH5e1i3AFBAwM1v8=;
        b=FkH9y2ybKE18FNKhDndmsYxvTYUISKvPx3eEZ7WQVsHSgzAdAorQifVzsdSRggBIlA
         iIxScMSQ92KDtJeuWeEThjPFq8e6jqQTqkO0UCWvFzrVAjb0YE6w9v8QODeoltrHJqoJ
         +sOnxmxYS58h4zs6l7flow3rJxF4s7zvIjJvTJvqaiIvRyo0KC/drWpO5ZfeqAX8Hr8P
         9tYQVweKAdbC4+TgJMPZEQIh2Mul7f0LDGS/I5QljP39XqZgexQ0hRkneZ8r/CxEewJY
         hW8R6L6JTil/vlHHMTfdfTAcyQgZ/EnbVdKaE9QgHMwSao2VgkTtUgBpg4OA1vS+fOAr
         75XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757794612; x=1758399412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Koaj6pqpf5k3Jy2jPYnNq/imDVBkH5e1i3AFBAwM1v8=;
        b=vwSBGbNtZxAMtNNhnF8xVqzvD4/UbTReoa8V8Rvb25/tteDYA5lhKuwhpAaxNsZ86q
         2eOuPIv2cXcx/Lq5pB/K0/QeIf0Fj/YZ/z5ZhXAjFTxj+hBxJRhBpcx/e/cnd/tTQtF8
         8ClI90dZDZbv2TQG9QD9o+V3uuyOr2g51arNgR2TTIvh9q+gpL9uJx41tlhH2NTquLeh
         eIH5h0GfxdV4YUcO5NceAlqMGjuwvHne/sdqI8Nm1/LACRj78EEyaFkNQCxQnT1cSDvT
         mDMZlBP2Wfv3ssTtCtrW1Ia1dMasqZ4nCxLnRVGmkQVdv7btTBqGj6OpW78+2GnQ7Fu8
         pRbw==
X-Forwarded-Encrypted: i=1; AJvYcCXaqgiMhf6oTF22Em/BX8hfHCKZqihztNCMVJ+NGp14DagRUM/qKyfp77kHMpizTjoXNib7KHcBNK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUa2FEB3zGb8kKIbIsMFUENQzuB95acaNZoU2nWrFpb3y7hORV
	MvTdnPoVnOIbeOgSGsszSjJgwQofhAgsuILiAGnHcXUG7U374SD2VNI9
X-Gm-Gg: ASbGncsfRqjv7m2s2YtDtaip27gxNMjHZYeuADOXi+YktA/sx9MkpJtTbcbpbSl5SKH
	l6VuXWbUCKW15GaX1HQSEW3XloPtgciEpMXRGTnuVe47vMw4H56AibLaysJ5ZkFErcooLpKO3wX
	/VcGrjSGlJFefBqTlbS1pQ8fCei7KlRSOeCud6WO4sNYnFYYLF4SSiCWMc9dSo/y3j4mH8N9RlV
	gdR4hJtwXvjq0aUPlw78T2kSgIZPSij7m9J6YX3ii0WIlwsX5QjNg1f14iUhGqth/ewiKAL5yif
	DUwTbUE9SkCP4f2GJ1UnO358YLs93o2IUEbq+ahDrdGZhJ8zKGZgwzRD/HuECrJz1voFU5tp8vf
	am8bQ/h+q1vdth2lR9l3Wfql6XQh1bZvQ
X-Google-Smtp-Source: AGHT+IHM94ZQbz7LSAD6t0BWLw0dw4XltmvObHjg9ikAWt94vPnfOCsjro/zNpc96RTnU6ULUDYJDg==
X-Received: by 2002:a05:600c:1d29:b0:45f:2aa0:cc07 with SMTP id 5b1f17b1804b1-45f2af44393mr1464885e9.29.1757794611659;
        Sat, 13 Sep 2025 13:16:51 -0700 (PDT)
Received: from localhost ([185.63.82.103])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e015bf73csm57532735e9.11.2025.09.13.13.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 13:16:51 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liang Yang <liang.yang@amlogic.com>,
	Feng Chen <feng.chen@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>,
	linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: amlogic: Fix error checking on regmap_write call
Date: Sat, 13 Sep 2025 21:15:58 +0100
Message-ID: <20250913201558.1338180-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently a call to regmap_write is not being error checked because the
return checke is being performed on the variable ret and this variable
is not assigned the return value from the regmap_write call. Fix this
by adding in the missing assignment.

Fixes: 4670db6f32e9 ("spi: amlogic: add driver for Amlogic SPI Flash Controller")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/spi/spi-amlogic-spifc-a4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a4.c b/drivers/spi/spi-amlogic-spifc-a4.c
index 4ca8e82fdc67..4338d00e56a6 100644
--- a/drivers/spi/spi-amlogic-spifc-a4.c
+++ b/drivers/spi/spi-amlogic-spifc-a4.c
@@ -420,7 +420,7 @@ static int aml_sfc_dma_buffer_setup(struct aml_sfc *sfc, void *databuf,
 		goto out_map_data;
 
 	cmd = CMD_DATA_ADDRH(sfc->daddr);
-	regmap_write(sfc->regmap_base, SFC_CMD, cmd);
+	ret = regmap_write(sfc->regmap_base, SFC_CMD, cmd);
 	if (ret)
 		goto out_map_data;
 
-- 
2.51.0


