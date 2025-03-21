Return-Path: <linux-spi+bounces-7269-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0231BA6BAF3
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 13:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30C33BE425
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 12:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5229C22A7F0;
	Fri, 21 Mar 2025 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwyKucgd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A4A226CF8
	for <linux-spi@vger.kernel.org>; Fri, 21 Mar 2025 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560882; cv=none; b=b/qvsLwhEcnQ4PmuB/XHbyKfczAbWqSGQ9oVYDKKSkceNQrZu/wlZBKkPgEp5K7XCPj8Z9iMIjgzMMow95OFy3LeKUk7c5ltZ7vRYyfZZ4HdUEdYz81k5tMD8S/ZjvU806YMYEjJ9qZFxObm3tLAtHygAtV3v9b8Bs4qQrUAblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560882; c=relaxed/simple;
	bh=QGBMCqw+5BdhL+voht3B+7pdNey58iclUXO+oz6ej8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DmLY7IL/dZ9VSKZaANVMqzdHqcC+k3PhpKTZqxoojNP7XdEMLXofdfASC3QyLgjIPDbWC/jFryiA6mlzlpsl5yrOJ65Izdft2d2jCjKJ13FUXnpXHABovuyZJwvTgeW1jsdUoHayjQ4/J15zghl4roFR4+Hwt6Sd9VgFZdp5H8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwyKucgd; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso3237546a91.3
        for <linux-spi@vger.kernel.org>; Fri, 21 Mar 2025 05:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742560880; x=1743165680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=diANNUeYaMPdVTg7XPTc4czQqkwfrVpFES5HMSIw3o0=;
        b=hwyKucgdNhzQ1DnUDFUazsa+VcIXgXL3FVdJi/OX8PgbH3UNTnHWEHzR4TkfwLvKUr
         Ip4CGzVInSLF8HcENzwOoMm1uXK3UXerkkGMIsAnEJdMvDYGyRF+1ka7mqEj7QOwmRCw
         0cvAjvS0AP+6djetLBCnkuWdyr2BB0JrpfhRV5BIM2/yInHJPKlOv8jFg7UgVbHLNfmM
         LD2CB2iFiTuuWgUHFDGkGjud12YeZzOcbHvEqwpe0eZtOD2dod77CSHbqKP2S8zRSlOM
         xQgMx4+lnDzDWo1ldrDoxImUFXhRIbsJWGi6ZIEih0579o3r1waFQWYb4WX7kbG9L8O6
         SoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560880; x=1743165680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diANNUeYaMPdVTg7XPTc4czQqkwfrVpFES5HMSIw3o0=;
        b=tMS5+222Xq/RwiHex+oKC1/wTy8CBcdFnKRM+zL6AUhBjD2eRccytUK7Eg+Lehg6ci
         TbQmF+ud+5OlKwNDZYCKQJAqqlLZ0Gw3XzrAvbOAgvL7zPwzBH7AQDl8cfbTNijs+Aet
         kDkvMUMSiuLetpA+dLBDw8cINxYKZasgKcRSC91HIZu6q9I+C9q4NpqtFc/GXU6KUBil
         9F/nYROyjY3aTic+hC2RZ2i476qQkpCeWIw6bE2X3W6332hJtmzdTSg3p+EI1+BZE7bv
         7+3kT6BHXrgZxQajG1E9NwiQLnWYtxeWatGttFxqe6DJ6m4RDRHTxuXp4yKZ+51dtDvo
         n9QQ==
X-Gm-Message-State: AOJu0YwrABl/HkNyrvb0AFR2WmEp5nT5E6XbN4dkvnH7cMCuXtCJ1OHm
	GlSlEkI1WmVZKDp+ZmWOuDOr/9vFRvuisJHhtuhx+Sk5jWNRP1gN
X-Gm-Gg: ASbGncunD7cFKrklq+EjLKaUFf+1WIyqyrEOEeSP0XFa2TMnkWdlj4XZCnqvP3ZUzRs
	Eyy8vY13fTrFYCnZDaiQwI/rSW7eu71qu24MN/Zhjq7w5khjmfaRwwsS5Z2lcL6kGqaI3i0hZLk
	XjhCXTtnD+dkhcy7HA59eYHUt4e6LGNfmJNcKJUQRbO+ve77hYGc7YmMbAH1xXcCzr9yiyyp8rP
	hWKGQKuR6SuLGACu7C3++BBknnL6DhMBKBDW5gQRUQvFBggvn4lFX7n0vXUCC3YYUod9n+D1d+7
	HK3hp7qtien8cgSOUQ21cDFduvbariaaQFQBB/G4TsWzxfNUdB2OCrda
X-Google-Smtp-Source: AGHT+IGZilBpVbmHwXqE1RayB8VznKS8a5ZcQyaITGTBbOO5RAWktzmx/m01r2dAzCV2xhRFLinUDQ==
X-Received: by 2002:a17:90b:5826:b0:2f6:d266:f462 with SMTP id 98e67ed59e1d1-3030ff0df9dmr4523968a91.35.1742560879930;
        Fri, 21 Mar 2025 05:41:19 -0700 (PDT)
Received: from localhost.localdomain ([147.11.105.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf635929sm6424975a91.40.2025.03.21.05.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:41:19 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Fri, 21 Mar 2025 20:40:21 +0800
Subject: [PATCH 1/2] spi: fsl-qsi: Optimize fsl_qspi struct
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-spi-v1-1-b9939baa64b6@gmail.com>
References: <20250321-spi-v1-0-b9939baa64b6@gmail.com>
In-Reply-To: <20250321-spi-v1-0-b9939baa64b6@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Volker Haspel <volker.haspel@linutronix.de>, 
 John Ogness <john.ogness@linutronix.de>, imx@lists.linux.dev, 
 Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.14.2

Reorgize the members of the fsl_qspi struct to:
  - Reduce a hole in the struct.
  - Group members required by each op (e.g., iobase, ahb_addr,
    devtype_data and lock) into the same cacheline.

Before:
struct fsl_qspi {
	[...]

	/* size: 176, cachelines: 3, members: 11 */
	/* sum members: 168, holes: 1, sum holes: 4 */
	/* padding: 4 */
	/* member types with holes: 1, total: 1 */
	/* last cacheline: 48 bytes */
};

after:
struct fsl_qspi {
	void *                     iobase;               /*     0     8 */
	void *                     ahb_addr;             /*     8     8 */
	const struct fsl_qspi_devtype_data  * devtype_data; /*    16     8 */
	struct mutex               lock;                 /*    24    32 */
	struct completion          c;                    /*    56    32 */

	/* XXX last struct has 1 hole */

	/* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
	struct clk *               clk;                  /*    88     8 */
	struct clk *               clk_en;               /*    96     8 */
	struct pm_qos_request      pm_qos_req;           /*   104    48 */
	/* --- cacheline 2 boundary (128 bytes) was 24 bytes ago --- */
	struct device *            dev;                  /*   152     8 */
	int                        selected;             /*   160     4 */
	u32                        memmap_phy;           /*   164     4 */

	/* size: 168, cachelines: 3, members: 11 */
	/* member types with holes: 1, total: 1 */
	/* last cacheline: 40 bytes */
};

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/spi/spi-fsl-qspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 355e6a39fb41896f460e2474a90b8f0b42068ff3..efd87f44c63a5b12b76538aa459ca8eb203b9dcd 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -264,14 +264,14 @@ static const struct fsl_qspi_devtype_data ls2080a_data = {
 struct fsl_qspi {
 	void __iomem *iobase;
 	void __iomem *ahb_addr;
-	u32 memmap_phy;
-	struct clk *clk, *clk_en;
-	struct device *dev;
-	struct completion c;
 	const struct fsl_qspi_devtype_data *devtype_data;
 	struct mutex lock;
+	struct completion c;
+	struct clk *clk, *clk_en;
 	struct pm_qos_request pm_qos_req;
+	struct device *dev;
 	int selected;
+	u32 memmap_phy;
 };
 
 static inline int needs_swap_endian(struct fsl_qspi *q)

-- 
2.48.1


