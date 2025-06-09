Return-Path: <linux-spi+bounces-8398-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5EDAD2281
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 17:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D23718818AC
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 15:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7FA20125F;
	Mon,  9 Jun 2025 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDO9dFl4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B9E1D5145
	for <linux-spi@vger.kernel.org>; Mon,  9 Jun 2025 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483221; cv=none; b=cnWuqE4kQmNrbgAqPFg856eTv9RHnNrk9cN8cjk6euapW4J6nvk61nA4jVlae4MfjeNaucs5op73X7Ed4f30Zm4TexrI39g/heIguuO3MIbh9WGTgIH36lcnEVbtGZOeYJ1ukO+DcTSaPsCxd00ObfPIxi7A0qf8b/b0kbJD92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483221; c=relaxed/simple;
	bh=Ey72OPsSmpUH6hcCG9cbHDrh6u+W0gYAKs5MnbTd5ew=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pveNGvvleljuG0t4lBZOf0YrwxxlbW9QrpwN7M/OS0GEzCvPl1qykFrWG/rhv72dPkbq360ptSGbTwrOwgfsgsEIhzVLjRDLNtSHbwjKAfHZ3W1tkgHvAjPWPS4YKc0Tg65Lbaf3Or8PZiG95zBDkSvz391x3sTBCMzO+3rLvas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NDO9dFl4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450dd065828so30130435e9.2
        for <linux-spi@vger.kernel.org>; Mon, 09 Jun 2025 08:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749483217; x=1750088017; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PvtGT/gXZy9G0z7KUPcczavaKT2KAY8YSEGerfvgk+k=;
        b=NDO9dFl4z+KZi900V6b+cczdI2ZKvmKWavUCpktm2ILbc+6nvWc3k4uyuU4g0PFGP8
         DvtK+RFqlT8C7HjVvLo+6Wo3/bpx0NtBzcDPuXl0v9aMFLgRaBwWUlyL/29DjgisTBVP
         uVWGUDwSvQ2Ftqclg/fzN45pcvAaXHfbpPaxnP3M1BZBWhgG1FfBcEl5kIT0vlexDVFW
         kCzVV8y6DhmurVmD8WxX2MwtH0FYS000EqPF9gD84b6Z87nLn+RbIIU6VGARzPTHA2fu
         2yzClwfpFOA/LGk/1X1lAQEfzi9ptMSygVcgvG0j89bmcCPKU7i0JfbgREpZGquskFsx
         eC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749483217; x=1750088017;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PvtGT/gXZy9G0z7KUPcczavaKT2KAY8YSEGerfvgk+k=;
        b=GtpraEShfg9uKmP/bqJc/Ebq9X0t3IdU4GlYGgHrqw62UwIzPugkmnSvuD76RI9c0p
         wFyp9kPv7GO5RzXNa20iOmd9MU4NTX95hP7bd6IT+zEcbV9a2Zg08Hzb1xoqshOFEDWk
         U35Fwnbwsb/2tPFgLkdqOor9FUHQgGrnemNwgNnaGsnLoSSh4JiefowzprAyR9nxMTC3
         yvs4SjeEMaddVIz2QhWaxj8PXe/01/J0OnZPLA5LGESH9p9FKFLiq4q1g6r9YWgi1v+6
         wGayyK3Ih0OIKpvLiOU5vffFxZAxsR6tH/1809sMD4eRj5ocUP58oPHe2KeEX/Czl7mA
         tCTQ==
X-Forwarded-Encrypted: i=1; AJvYcCViEdCVkXcffNwzrOgTpBz6bXZ6QinH1adQo0vNN98sV6pFaLRHkayQqT01PvSG/zW+w7rbmYZU2XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX29ceG50BzidDamkjSX2qyJid84v7zQN+EG36bnvN9GFIGKDO
	mQtIGSB9bgPb5aZtV9HvOpgvA17IEbS2/IUhyKp5SVQ4Ojzd07Csp7elcvVf0uAx5E4jP0NLzoD
	GJ9YHrns=
X-Gm-Gg: ASbGnctaNFDVphZkTmZQL+lrOwwIih2+j8/7RYh9Ks8sc9d12K28RTY5By6Wy/OQuDb
	rnPexeGAUPmsHBujN7regXeiEKbJM2PBF67U0toqIu/ctKvkt1cXtyq7kzc7FvpO4ijJQnlytpc
	Yc3ZHpXxU5Zx18mfJQdTKRHNEUx2Rz/lzF1VGpO54wosJjr61Z/U3dGksoD8r9i2ndWk9VcffAs
	Pq0diYYL2jnP1/XexW0JCmDnEPMDCwqHwhRh5fpTbUCYA4e7CTrhITbYEZLMcxTDeSzoU9REsHw
	kB3jwO1sA7PGoEBSFpUDEDfGy0iwJWkTUk5hLqB5SYDBq17sr48smDPGtguoPXn9cAbjGWk=
X-Google-Smtp-Source: AGHT+IGUecRwAIMHRhZ9jzGvMSqw8sw1BbFuESQIxyKOrlJ4Q6pTMh4lszRudkvpP6BGsmhYVVJ00A==
X-Received: by 2002:a05:600c:8212:b0:450:cd50:3c66 with SMTP id 5b1f17b1804b1-452014b39dfmr121204185e9.29.1749483217347;
        Mon, 09 Jun 2025 08:33:37 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452137277basm115728695e9.32.2025.06.09.08.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 08:33:36 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/4] spi: spi-fsl-dspi: Target mode improvements
Date: Mon, 09 Jun 2025 16:32:37 +0100
Message-Id: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJX+RmgC/22NQQ6CMBBFr0Jm7Zi2hgquuIdh0cIUxkhLWkMwh
 LtbSdy5fC/572+QKDIluBUbRFo4cfAZ5KmAbjR+IOQ+MyihSlEqhQ8zUUK/zphmxn4yaOr6Spa
 ss9pC3s2RHK9H895mHjm9QnwfF4v82l+t+lNbJAqUQlekLiQ6p5snexPDOcQB2n3fP+qH+z+zA
 AAA
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>
X-Mailer: b4 0.14.0

Improve usability of target mode by reporting FIFO errors and increasing
the buffer size when DMA is used. While we're touching DMA stuff also
switch to non-coherent memory, although this is unrelated to target
mode.

The first commit is marked as a fix because it can fix intermittent
issues with existing transfers, rather than the later fixes which
improve larger than FIFO target mode transfers which would have never
worked.

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (3):
      spi: spi-fsl-dspi: Clear completion counter before initiating transfer
      spi: spi-fsl-dspi: Use non-coherent memory for DMA
      spi: spi-fsl-dspi: Report FIFO overflows as errors

Larisa Grigore (1):
      spi: spi-fsl-dspi: Increase DMA buffer size

 drivers/spi/spi-fsl-dspi.c | 128 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 102 insertions(+), 26 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250522-james-nxp-spi-dma-a997ebebfb6b

Best regards,
-- 
James Clark <james.clark@linaro.org>


