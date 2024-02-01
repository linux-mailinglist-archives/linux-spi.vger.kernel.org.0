Return-Path: <linux-spi+bounces-940-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F0284545E
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 10:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61581C25067
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8098D4DA0E;
	Thu,  1 Feb 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkyE1XfQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057A24D9EB
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780645; cv=none; b=MzjHWU0stehJ5h9RYbKCtzw7hAP7DuN3urJt9AUpZmLMD3dntA1fYtGcXy3c5ND4l9zoFYppNyiNtUmLBK5qsya2l15rbpC0sm6BuG+JC6AqHA5g3SlAcXJHxM824NY1akmSEH2wd8mS5e/lPVSFePJC7LJJVww0kpQezeVlqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780645; c=relaxed/simple;
	bh=/OAiawsC5YSN9PF5oYhwgBAfUh1EK/H2AToyv33zF24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=niKDJH2ypaAiScwmTG6mSQ34FU9EDSdg+1vQzXgIU66FzmNg4baaD2F4UuHeIjFTPGr3XddyFYZvc1hx28grffiaLyfPQIveEM3QyKfI9VmWlxQohiqccT08Mj+3KQ1LM8VpSSaqP4vy7GmXV8sY12feYb+3FGGWsA1TtFjYIt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkyE1XfQ; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-363923728aaso3412865ab.0
        for <linux-spi@vger.kernel.org>; Thu, 01 Feb 2024 01:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706780643; x=1707385443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yh0L/4UkHUI+FuJ0B+Zs8HedEUkaHqmAc7rdEuQbRD0=;
        b=mkyE1XfQi3FMmDru2OpIJv/ladUL1NXmwJmOs+Ej8oCv9o6s4o9BvGOwBEfqlh4EYB
         XmZQzYM5+gdK2i5X4/A1XiJONu/L3kU1EIjpN7SeWo46IJbN2+NbYtJ5rh/b59Hwsbfs
         35z54PwwqIIHxmHwBRPymuKJimm0ZIkfdheQYb/RmSGPXpqPZzjaQt/SyVzx657/a2LL
         QbuCGoosmMVspTvxzQsnY5pIJ9HQxOi+7kBon2Q66HV/7NfH6L3d4WOR9YtwTeCPxFBn
         YP70mURhnNRX55JWYbPQJg2wICvnAUcfQeXHPeEmpQjtyz80ezHtxQ4GSp91UHdnvW+k
         1DZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780643; x=1707385443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yh0L/4UkHUI+FuJ0B+Zs8HedEUkaHqmAc7rdEuQbRD0=;
        b=cE/vRWru58nFL+7Z0pYuU4SYTu0PIvxXG+OPWHjMsvgTnzbc5JirVlRBSNnvjGQvxW
         /C0QvbV2wLRI2PcFAc+wr1zv9BzVNKwwlYOidExuxIccZMbKgFse/mMkna9b/pB2+RR+
         E+ENcftVHc6gTAsHDUDZ/uHXOiIndvTKkIUTCSLQFjBmYABBNMrUgABMrzQ1pqG2EZs2
         PE4xKc/iyNk6i5jRTKMcX9zsKhlFmeSmMrBZLy9vv7uRUFlNQS47pPGLFIGAsPjXuPOC
         USkgn9r/60VVYpfKvfkpNfyOfXVQNRpUUAou4MuJBVfL07ePs6sGjVz+NkUwJ+cfnL1V
         IBxA==
X-Gm-Message-State: AOJu0Yw4v4MIv10s3W7GuO93v0PWp+KsqkZ9v/zmRPiQD5UqJ7mzCS5s
	RYgnUaNre//jGv4suHaq+B2stGUzqht8k/1fLQ4Bl/tGmplBM6b4
X-Google-Smtp-Source: AGHT+IH+XgPXNFKkJpG7P27Z9/gNLhny1ofBMZo8aI8B+L3YRW8BdTpkGEsdKmS2l3W1N52e/vwFOg==
X-Received: by 2002:a05:6e02:1d85:b0:363:7f81:6bda with SMTP id h5-20020a056e021d8500b003637f816bdamr2625300ila.15.1706780642895;
        Thu, 01 Feb 2024 01:44:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV/R4YRO6kC45uz1ozc8Zu8JEQzMXGKzxEIwwWt6+5HQiT+ZojDkyDRNlkthbsTws596aFaNJcEbGXqHrxG0yQaxxwa1u4hjzUzA50EiX1Arda420MA2zx++wVu0JfJhjFzf/fc68d1lJzXx5rhb/orzFqvTK+WpCah8D9POY3OnCaTJAeEjLPjexyqT7pTtcEb+H/6A0VF4MILCbZ7bklTzpNjXBwx4QIEu86A9N6qnCgNioyGCBJx0REPffBF87+lp6MVzFMTOZ/PFvLnNgKg6I3oQ2RYKTDqGiGjLZisaAtoAQIoQaBYl2nL6SuIpYs3Pw==
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 31-20020a630d5f000000b005c21c23180bsm11972741pgn.76.2024.02.01.01.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:44:01 -0800 (PST)
Received: from hqs-appsw-appswa2.mp600.macronix.com (linux-patcher [172.17.236.35])
	by twhmp6px (Postfix) with ESMTPS id 527878095A;
	Thu,  1 Feb 2024 17:50:02 +0800 (CST)
From: Jaime Liao <jaimeliao.tw@gmail.com>
To: linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org,
	tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	broonie@kernel.org
Cc: leoyu@mxic.com.tw,
	jaimeliao@mxic.com.tw
Subject: [PATCH v8 3/9] mtd: spi-nor: core: Allow specifying the byte order in Octal DTR mode
Date: Thu,  1 Feb 2024 17:43:47 +0800
Message-Id: <20240201094353.33281-4-jaimeliao.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
References: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JaimeLiao <jaimeliao@mxic.com.tw>

Macronix swaps bytes on a 16-bit boundary when configured in Octal DTR.
The byte order of 16-bit words is swapped when read or written in 8D-8D-8D
mode compared to STR modes. Allow operations to specify the byte order in
DTR mode, so that controllers can swap the bytes back at run-time to
address the flash's endianness requirements, if they are capable. If the
controllers are not capable of swapping the bytes, the protocol is
downgrade via spi_nor_spimem_adjust_hwcaps(). When available, the swapping
of the bytes is always done regardless if it's a data or register access,
so that we comply with the JESD216 requirements: "Byte order of 16-bit
words is swapped when read in 8D-8D-8D mode compared to 1-1-1".

Merge Tudor's patch and add modifications for suiting newer version
of Linux kernel.

Suggested-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
---
 drivers/mtd/spi-nor/core.c | 5 +++++
 drivers/mtd/spi-nor/core.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 4129764fad8c..0076007e1cde 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -113,6 +113,11 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 		op->cmd.opcode = (op->cmd.opcode << 8) | ext;
 		op->cmd.nbytes = 2;
 	}
+
+	/* SWAP16 is only applicable when Octal DTR mode */
+	if (nor->read_proto == SNOR_PROTO_8_8_8_DTR)
+		if (nor->flags & SNOR_F_SWAP16)
+			op->data.swap16 = true;
 }
 
 /**
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index d36c0e072954..3c5190ac0a79 100644
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


