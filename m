Return-Path: <linux-spi+bounces-3894-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5BA9346E0
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 05:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2DD1F23482
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 03:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB7F40856;
	Thu, 18 Jul 2024 03:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuKqI5h7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5860639FE4;
	Thu, 18 Jul 2024 03:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721274468; cv=none; b=miBo4yg+BN/hTBiNch5j2J6yDFF05PFmVac6VQQNInwSI1dLlL3/tCa4hFXNIeRhVGYr1Mzcyuc5xfzT12XkogJbS+oYVcME4cWqhth/aQ/dFLi2S9mLxlr+C4ePqKYmLUIPUn3F8rVvXdKBoITWF7QVF2+3ux/3eZeu9GZya08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721274468; c=relaxed/simple;
	bh=YfVErJFWvQAjc+YAokwbZxUEeqlwW35HO2SBJoUvN7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gu8aJcn731yfzo0ybSKXG3imAxUOPyDHHotb+eIiJ7K9BHrI/3J33KW4i4wUlp9L+VNgmg41brcesGKUL0mks2gS5HPWB4im3HRuDL6y27BuTBi435mbl+1Vnw4HISR6W69qt1VjmSULAMdiJa5rgv2U2/F5bl/+QojxKh6MeRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuKqI5h7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b0bc1ef81so265514b3a.1;
        Wed, 17 Jul 2024 20:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721274466; x=1721879266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGxTXo990ti5lAyVI8ZehxzUFXPwz6MqQx7qAzjMfhw=;
        b=iuKqI5h7yvwsRKP6p4oI3bkqNqCOiYfuKShoNX6wE9RPA4eF43a7qcjN4aeWwbmWhi
         mB8/XDtY/JKmtl7T5DzYDfubEtGlWgVSPUM4ZCxgaQaQBDVNLhC3fdLglH00oLqnzY0E
         JNwwF37K55FoczBJiUpmgjwgK2KyOBJvJbpBVGwlkjfuAHHHsrT/FFEVap/7CNkDbfhd
         4nXr3ExOWr1V2xKVWl57bNg6Yd/F4Naqfu3i1ugxjzVH+nlBh+UpHCoLRysbi8H3atnk
         6ChU+JnGUMhesjcC/C6ree1pDm/L16yaRnEo8htrWx6tAyMsWpqPzx79wg+rMf5JJSZb
         R4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721274466; x=1721879266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGxTXo990ti5lAyVI8ZehxzUFXPwz6MqQx7qAzjMfhw=;
        b=NHTra0L6I8nrskdkLoG7VcPecaXjp1MVIbskI/qpaieeVJNMQcdkjDBCOoh3IiT0Os
         QfEOUPvubBMqyKxju6PVyyoxq6CZcBELRwQnOEJqFu2ufHSak/Mo3NLWV6Q7j1X1wESw
         CHk9r74Czz9JEMhvJdd0E/NqOPUTiwdRuE8ottUxDQ1rzCtzHVl6OaFWKDLQunS/s/rD
         BE3F47ieBLsy1Szmvgzq01nkxjWM8pzuEQIhYdheqNbUrZ+OISJFa7Y8Z1Pbq9TeojtO
         3dsd+2RUNoA10BhWM6xVvKoOZYIoUg0mC8WgO7nOqn3bYBVFPz2TwdvuDFzbMGys6a0c
         1ZFg==
X-Forwarded-Encrypted: i=1; AJvYcCW2KLQ3rQHvvBTZTdP2pBPCSSgTgitkmINH96DbS6YcdEdpGo8KvBvRTo2T4My44888taM0opA/YtPoSvE2+CJO6H9hZ0D/X+mVyvJngv0COAs0KP0UyKtSazRpYXWkLqW+ZnvWatRx
X-Gm-Message-State: AOJu0Yz0kOQpEVoa2BdcX3bOQMnlm382jSBfWN3rAq8ix2WCMl4eSNUC
	LKyuwPkD/B8uX4QnQFz3kYsx1qSBJZcC9Hd3IyOA5hGbQkRetvLT
X-Google-Smtp-Source: AGHT+IFHhgdm/fpkHpJp5xeIvoQlchgAmcADiPZHZAKYg0ls+CPuWC+Msqnn+IJRt9GxdMHY5Hry0A==
X-Received: by 2002:a05:6a00:23c3:b0:704:32dc:c4e4 with SMTP id d2e1a72fcca58-70ce4d8392bmr4782637b3a.1.1721274466500;
        Wed, 17 Jul 2024 20:47:46 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecabf2fsm8838583b3a.182.2024.07.17.20.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 20:47:46 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 5B94580720;
	Thu, 18 Jul 2024 11:56:57 +0800 (CST)
From: AlvinZhou <alvinzhou.tw@gmail.com>
To: linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	broonie@kernel.org
Cc: chengminglin@mxic.com.tw,
	leoyu@mxic.com.tw,
	AlvinZhou <alvinzhou@mxic.com.tw>,
	JaimeLiao <jaimeliao@mxic.com.tw>
Subject: [PATCH v9 3/6] mtd: spi-nor: core: Allow specifying the byte order in Octal DTR mode
Date: Thu, 18 Jul 2024 11:46:11 +0800
Message-Id: <20240718034614.484018-4-alvinzhou.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
References: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AlvinZhou <alvinzhou@mxic.com.tw>

From: Tudor Ambarus <tudor.ambarus@linaro.org>

Macronix swaps bytes on a 16-bit boundary when configured in Octal DTR.
The byte order of 16-bit words is swapped when read or written in 8D-8D-8D
mode compared to STR modes. Allow operations to specify the byte order in
DTR mode, so that controllers can swap the bytes back at run-time to
address the flash's endianness requirements, if they are capable. If the
controller is not capable of swapping the bytes, the protocol is downgrade
via spi_nor_spimem_adjust_hwcaps(). When available, the swapping of the
bytes is always done regardless if it's a data or register access, so that
it comply with the JESD216 requirements: "Byte order of 16-bit words is
swapped when read in 8D-8D-8D mode compared to 1-1-1".

Merge Tudor's patch and add modifications for suiting newer version
of Linux kernel.

Suggested-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
---
 drivers/mtd/spi-nor/core.c | 4 ++++
 drivers/mtd/spi-nor/core.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 028514c6996f..31f57b17023f 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -113,6 +113,10 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 		op->cmd.opcode = (op->cmd.opcode << 8) | ext;
 		op->cmd.nbytes = 2;
 	}
+
+	/* SWAP16 is only applicable when Octal DTR mode */
+	if (proto == SNOR_PROTO_8_8_8_DTR && nor->flags & SNOR_F_SWAP16)
+		op->data.swap16 = true;
 }
 
 /**
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 442786685515..baf6c4b5912b 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -140,6 +140,7 @@ enum spi_nor_option_flags {
 	SNOR_F_RWW		= BIT(14),
 	SNOR_F_ECC		= BIT(15),
 	SNOR_F_NO_WP		= BIT(16),
+	SNOR_F_SWAP16		= BIT(17),
 };
 
 struct spi_nor_read_command {
-- 
2.25.1


