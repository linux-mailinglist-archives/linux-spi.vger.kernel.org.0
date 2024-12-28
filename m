Return-Path: <linux-spi+bounces-6198-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507159FDCCF
	for <lists+linux-spi@lfdr.de>; Sun, 29 Dec 2024 00:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6623A1385
	for <lists+linux-spi@lfdr.de>; Sat, 28 Dec 2024 23:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344E119E804;
	Sat, 28 Dec 2024 23:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj4C9qLR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3222A19CC08;
	Sat, 28 Dec 2024 23:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735428783; cv=none; b=hrgllqeDPE0bLJZlPrOI5pL/sG1g+tVXP8BFJyaMuz1N3e1Cuh8vnAF7RQ4/MjWyljDvLpVylr48SHMe7GsFkK2SbM3UVQVjWqdR7QEJr847FnVH0EaMCYihe+ot3+YziaE3l7IRS1fZpZ0hQjVob8TXZN7EtpbvowcWNBc/BlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735428783; c=relaxed/simple;
	bh=Xy7AdPQ3XNeeLhZR/TYDcrnRFX91WkBoxIfX4qqZmFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tw3jh1RjUWZFIQ5khoE+zdk0j30TYHmbqa/mXxaTX/mV7XnwsRTNBnRCKhzxzVHzLHPw3CP7sEwjHs+COMRAiX9oUuYazh2ivBIipqWKkXuSWe5bFlu1B0UAMIpNLjwXdqu2i7m06gTb4t0QCuYRRP259pkTRhPI1U8xJlRMc44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zj4C9qLR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so93264835e9.0;
        Sat, 28 Dec 2024 15:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735428779; x=1736033579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOT7K8Ya5QmS9KbZEm2dNA6PzTUyykxaRlEoFqze/Wo=;
        b=Zj4C9qLRZkTauyAzggzOqoO0rxQQ85v6XR6BvssL45u/Uz0r8+jo/VZvMeplkZyXhW
         01jnKNt3MLWg5OoLA+COOA3ifjy21pTwferdRTYMdMe2DcKdtTKaS5XNC/lLzkE4WOf6
         Id9hW+k9vZzPnjJLp9M3eh91WcdIZ6XrsS8AygEktd5OIwq2fQvVIbh719txTWUN8Q7S
         Pb9W/rZEjUmbsS8aQPR/MSawh3r/CG9OuDUBP5luu7SxlfElnTqWc6YOLtPr4pV20Y07
         tHyZ3zj/kbQx4/o/sf7dEtPfonex2/zl8APWjlTkWgcg0uqi/w4XiZX7zSGJLzlSlyYL
         nzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735428779; x=1736033579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOT7K8Ya5QmS9KbZEm2dNA6PzTUyykxaRlEoFqze/Wo=;
        b=GvRDxmXuEoqhs8IDEmFQTY+qRPMPN8TOubytchxjczya+vKOb4ZZaFpmBroMje5aOi
         25ZTM89RUmfU/bgDG4W3cHGRxEDI6SDRz+Yhvd12UVK7iF77s1rdrxlGhDS+TpfetBjJ
         Zm1sFqB8yIgLhE5YFp+irLLbIEahhg4Nf2AHt/jWX+ZZl/3AN/Bph1afgrqWhlIYYwjl
         ts5NRLvyY37id0Ii7fbqpUxeoBIEM7HmP6HulPy5sHWOREENWN9RnG8ZLBWeojCYAxMv
         TY01b1u8r2XNgIA0QpLYXRiPyn5Tq4cATP8uzE7AV+/wNgheY5VW5RdOEUn6Rhk9QcEc
         +khw==
X-Forwarded-Encrypted: i=1; AJvYcCUP7I6CMuetwNtPSwRxiOJxFsiBosraeC+O0Vu59UZxQqs3oEg+4NAgwMsGHKtLY6I+oGGi456N1uc+@vger.kernel.org, AJvYcCUTXCulyQtaiEZK6eHZHAjOh1z7tfIj4SjImLzkRugEltMBegc/Gzvq7fnSYl5Rpij3oJLeihy4245lOx8U@vger.kernel.org, AJvYcCUTsiET1EIdSwBdxv2Iyr6CQn0gVyVcQkjsptRbEovu+yAy8xTpg1ojxA+KNH1kKgKEoLdcn2fou/Cs@vger.kernel.org, AJvYcCWMz1hExuTkrDKW1a9JUiIlbOS86vQ5NL3MV0WKRSuJsMtWbmstN6exOSD/8Bwk9cfuR6P/A+lhWUW/@vger.kernel.org, AJvYcCXkgR63ATtnaBpGjNIepOLw9HUUmxN1kehqEl1uaAJjk77kON76YuYhdLZd1FvvQblolL1rWPYuM18=@vger.kernel.org, AJvYcCXmBd2AbMddzYHmGw7bxY00Pz+Bw3fU8G0enm36XuukRUhGmme7VrtJPqT0PTWTTFItjYISiv8Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxqpWZVIZqc8uArVtkHI5hT8gKX2EiPPOKT213plQiqUknAWeig
	gUC+YrbyGsFmWU5i/UWZualKYvChDmchGqWBSpLJ5Qp61DfLF+u1
X-Gm-Gg: ASbGnctpEgwarxeDU1ysMRbboK/QQZQPimEIR6mNoKNEMIpx92HVYduDHCa52+oE11Q
	gtCwDR7KZIUpytnERTrfHxdd7aqldhwb/1Xf3KLjI6CQHfybQxweExK2kzSt4KI3DriQ0dsyV4x
	iwCxcq1iwA1kd94ryfiwxkjA7LHstiHO/FXEwaJP9PovxrPXzCxJrriHll8aD4YShIDNOVCnFyk
	t4Hw8Gk7ZVuInuZWLDMYehxl57fPcHN11rmvb+BTaL9/f+7ycB6xUboCg==
X-Google-Smtp-Source: AGHT+IEDx7wvGkLVUnT9AMtJHUHuNgRawRAtN+qgnC0Cj3E/aztBEivykLbd/wn9yN327aAFyzdA4Q==
X-Received: by 2002:a05:6000:1542:b0:385:fc70:7f6 with SMTP id ffacd0b85a97d-38a221e1f67mr24709765f8f.7.1735428779386;
        Sat, 28 Dec 2024 15:32:59 -0800 (PST)
Received: from localhost ([2a01:e0a:d9a:4c20:d6da:7147:f20e:31de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8a6ca5sm26538490f8f.86.2024.12.28.15.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 15:32:59 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Sun, 29 Dec 2024 00:32:44 +0100
Subject: [PATCH 5/6] net: stmmac: sti: Switch from CONFIG_PM_SLEEP guards
 to pm_sleep_ptr()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241229-update_pm_macro-v1-5-c7d4c4856336@gmail.com>
References: <20241229-update_pm_macro-v1-0-c7d4c4856336@gmail.com>
In-Reply-To: <20241229-update_pm_macro-v1-0-c7d4c4856336@gmail.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org, 
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-spi@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1773; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=Xy7AdPQ3XNeeLhZR/TYDcrnRFX91WkBoxIfX4qqZmFU=;
 b=owEBbQKS/ZANAwAIAechimjUEsK1AcsmYgBncIqkdCM7I2+fjKtHyJmXuIMRiTT3ConPrpraf
 j4VH3GYg+CJAjMEAAEIAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCZ3CKpAAKCRDnIYpo1BLC
 tWOLD/9mLv8T49Aj92DxuFqK+5R3cczwAA+SNhe7B2SwXvfVYYd3E77Y+/6R7e61V78SrnbI8gz
 uaBNqyvNBthY5MeF0I+NbwVeOCkA2B23GaLT+QSAAgc/lpqQ7wFVR3ISSUhZfAT5dU4co5VkvHM
 xnEYsquomiIFCIsoOVZw7fvrHUaCfpBwiyPXjs+jaTzfcq++bCknVVo0bsn9SrV9v6OIEzL4CxJ
 2Gec/Ah9nHgtAISBD8U11Ay92zy0/x8J2tmMEkLxjOFcmqZmJyYB0X1eyMts89qT1Xz+qxVwJ4b
 eGSEySEwcjMA401vbYtcTwgiaRaERA8MMXj2OjAznA2N2n1aswBx2ElmwHm1wBW2FXPfVapYd9u
 cKDauqd2bZioY7er4gOxCHnT7cvL+mGopN2wMggQ7N2mnGfAnVhUwo1BvvKnALB6XZUt4riUWco
 td11vz8xganX4BAkgJUrdabbCavIB95y7cYJOMpKAnQGDHRALdO3K/R9opffcvMi6xvmOl/amaJ
 z/7BF43VuNbdS0NTjhHxD5V9G5FlkeT31KscpPYrGl4XpRe4HaazkrXfMZr0DbWSBESGgi8Rj7V
 +MXQFC/biruMtBy8YzlG9rLxu1xkClx8ECgKGVnRJBpUo0oBdpjoD8/QjoS35kjJWNjGSlKyI9T
 uq80NJHRbLeVYQg==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based kernel configuration guards.

Link: https://lore.kernel.org/all/20240716180010.126987-1-rgallaispou@gmail.com
Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
index eabc4da9e1a985101643908d2efdb0b4acaa9d60..de9b6dfef15b3d0a503a3b55b3e9a42ee68c6141 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
@@ -313,7 +313,6 @@ static void sti_dwmac_remove(struct platform_device *pdev)
 	clk_disable_unprepare(dwmac->clk);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sti_dwmac_suspend(struct device *dev)
 {
 	struct sti_dwmac *dwmac = get_stmmac_bsp_priv(dev);
@@ -333,10 +332,9 @@ static int sti_dwmac_resume(struct device *dev)
 
 	return stmmac_resume(dev);
 }
-#endif /* CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(sti_dwmac_pm_ops, sti_dwmac_suspend,
-					   sti_dwmac_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(sti_dwmac_pm_ops, sti_dwmac_suspend,
+						  sti_dwmac_resume);
 
 static const struct sti_dwmac_of_data stih4xx_dwmac_data = {
 	.fix_retime_src = stih4xx_fix_retime_src,
@@ -353,7 +351,7 @@ static struct platform_driver sti_dwmac_driver = {
 	.remove = sti_dwmac_remove,
 	.driver = {
 		.name           = "sti-dwmac",
-		.pm		= &sti_dwmac_pm_ops,
+		.pm		= pm_sleep_ptr(&sti_dwmac_pm_ops),
 		.of_match_table = sti_dwmac_match,
 	},
 };

-- 
2.47.1


