Return-Path: <linux-spi+bounces-6194-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BA49FDCB6
	for <lists+linux-spi@lfdr.de>; Sun, 29 Dec 2024 00:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B99161AE5
	for <lists+linux-spi@lfdr.de>; Sat, 28 Dec 2024 23:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70941991BF;
	Sat, 28 Dec 2024 23:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0h2kofy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30AD2744B;
	Sat, 28 Dec 2024 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735428778; cv=none; b=EKpKOC3J7WznKqjpHfc2SSAU5YOBQoEjbRlFt4hlJk4OapV3lM2SPz0hAPvcq7S27WIESFiz3Ol7pJYKP2kb5z6ZewQ1ZCvj4FMLZNK4/0sKFUHuRqzBYP4Ikota8lqfxQQprmXbqACvb+Lt9ImVGY/12IJzTwPI6eHjK+5ydd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735428778; c=relaxed/simple;
	bh=pITQ3SISHmNURCP92MPtMIDVu2hGeerDTBhUOZa4ipk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ferV3yBQ1ccJxdXoZS47sZV6a4Lne9doRmyS97mfNZMajSkmaXz6JvQqv0U6mHsoBefdK87Vy9RD0tGIh3E/9gA3nodFqt1KXnwqZ2yEgyfdy9WMYCTWH5qYBxlnLSECvKV8WI+lqCFD8/lfMJhhvnV8AuGSydtRr2Dqdl1Wcj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0h2kofy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4368a293339so40158665e9.3;
        Sat, 28 Dec 2024 15:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735428775; x=1736033575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOndzP+gvkrgZs0qc02qdGu1OBtOTqc7KPMQjqAeOC0=;
        b=N0h2kofyyTrD89JYNJZmJEvY6eZM0oC3et/WGXVL/qCP1T1SFAotcvLOYH/0J79jsP
         YU1kf3vMEHDxRLOo3s9vWn1SaDpGG7NMO7rthybV+oCIRmvvlw1h8xz6Ig600gN154tX
         XUEfQyU9ZoNlzIcSWuMEbUceNrFQWsqIwhhQ8iIKnkt2/p8i/amEMiupvu+4cTixU9k4
         NXVgMfqPiPzqn4Nwfe8wcHsmUewZjB/4LaGk+wmmm4XT94+a71ynkPLjMFwnaYjl0cmh
         tdDPzlm9r4vvHoaDAvjWtI/z49TyCeT5PiFpdkchW+mhDocg8hoedEE7H6/WQURfik29
         bKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735428775; x=1736033575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOndzP+gvkrgZs0qc02qdGu1OBtOTqc7KPMQjqAeOC0=;
        b=WsiVZQ9+v1bAnDn+MxswZXFdLG3IB5YZjtmcEHk6fu6iCaIuDB58y77URiDGPuz1pU
         EUrvDwMc9vDYdXL5Zx33GSA12/2wqDqIbxrExWIs49hWwvBxsQdLK0nD4hswaTVc4r5F
         //UG5gAHpM1z6kNg+XOw79N8PZAE9WuVjXCzWxYd7ZbHOlO80Vlt5dUL5mwcR+QKXcVO
         AKqMVPIC2waMeY6te1BEOpPu1E5SRqn4HLTWlKxl2vqEzs3OE5ChdmSpRvrCjYrcIALT
         rpMuPo21s6IcM1k2lsEOYgpvaCar0HBjkVTZbNztIO09p8quAOeN33GA7xODkRn7ilRN
         h95Q==
X-Forwarded-Encrypted: i=1; AJvYcCUf2yM4r1hNIC6vCUCaBrCLHKbwiCd7kpB4vKgKCpMqvIxgzNnvDmGDuRaiRfO3ANSpP1zXvaxRgJI=@vger.kernel.org, AJvYcCWn6Yjrt9OUnV+B2LV7KZpeuH1DZQ1P5X2kO6idMe/p0t6etLcl3YCtiRvMl05O6L+Y7JNWwOa+dKEgNdrr@vger.kernel.org, AJvYcCX7BL7P/vj9928bWxwoAQ8Xydfeuz1gk4K4OCcAtMi1eQ6UAIOiOHTQB2EI8AollmfbHN05xbswcJRU@vger.kernel.org, AJvYcCX8OQaHCsibBieHAWZjXmJhlKWSiOi4FmdzXKN8AERTMrkCbU7Q6j4fupKRoflIxiBBJmO5xIvIt7FZ@vger.kernel.org, AJvYcCXWiyrjXHEePKczyR1aT7WLTLULqAOYQIYtz30jEOP7/e8OMk+daRysD72e/QXggpkwa0817ZeR@vger.kernel.org, AJvYcCXtww5QucPDwE03M6bUaxlj1PIEbnmIz0Dz0MVEaKnV3hYmL1m9Bwr300RwfpsjeDqXF+eKNUpr+SnA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7VMPfNki/oT2vEo/ijIRrm9lxW8FRuNH0T8gn1KQOTjOfaxpg
	mlxr1z6bAA4HdqbI8hnEuKjNG+MTmp7Jb52haLyhU8AxHcxjMRtG
X-Gm-Gg: ASbGncvvmUQhPlqZ7Kl6QFrprSuBQgRMlT62JWT0HGQdCeW5JKnT1yEVzas4IvT/qIc
	zkQZAsvIkst0qhXShemy2/8HNU+6kkuaLHpWIgjJqXrHk1zCOIgod0LrScbtBniE54M64HzJIBi
	+APmsfFkAht0BgFokvGSyqnModmgkSpaUp0jVYQHgyQfldDkmyLPkpHF/z5NP9eJLbLIVn8VJtC
	7ofVTe5I362nyBqtd6dxBrDPEOhaGARWBd3FWYeD+aWE/rfM51CR+3LPw==
X-Google-Smtp-Source: AGHT+IGe8Rwcmuo9VN1Lkb94sZXMSVEBxRAkdBXNxIt/1C+WWqsmcYg0Za15vXGe3lPDFNIsmfP2GQ==
X-Received: by 2002:a5d:64c8:0:b0:385:ec8d:8ca9 with SMTP id ffacd0b85a97d-38a223f5c0dmr23948509f8f.42.1735428775256;
        Sat, 28 Dec 2024 15:32:55 -0800 (PST)
Received: from localhost ([2a01:e0a:d9a:4c20:d6da:7147:f20e:31de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8475cesm25785410f8f.57.2024.12.28.15.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 15:32:55 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Sun, 29 Dec 2024 00:32:40 +0100
Subject: [PATCH 1/6] usb: dwc3: st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241229-update_pm_macro-v1-1-c7d4c4856336@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1573; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=pITQ3SISHmNURCP92MPtMIDVu2hGeerDTBhUOZa4ipk=;
 b=owEBbQKS/ZANAwAIAechimjUEsK1AcsmYgBncIqk5Qr8I8UCU+eXHkVfaa5GP81eSw5Fhp3mZ
 d3XzeEUBu2JAjMEAAEIAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCZ3CKpAAKCRDnIYpo1BLC
 tSpaD/92t81iuqxEUHcsYt5/Wd4eQOM5eEy6ZSir1T7uL3om6KgK6F9iIjSVBlFj6kEbB25IJ/h
 Bt1oVYolifnCrjPORvWAOSIw3MWCn1Osds32OjHMKm3W8nWcwB8bDoCMZBFhtpioriPGVKTjdZW
 PlEXPCH2XKcSdDdqB0Tw55BruLDg+f56q2fHv88gAjRqPgt7HS/IpOc/cdp04Z2k8rv0DL7Jg2M
 kUB00pqUBL0ghgILZkXQ/ylZJZSSQhyN7CeVrK7R6YBmUDf14wnLHEFOqj8Wj6hKR2cILhfftu2
 8x1MvvwQrupvZZoPTGCvPnt/E9Pe4N6LTXHY9fq+1a3Y5jJeFgnaYmgk6vAHEVT54lTshPXJ6iK
 oFdHkO6bjUb/71rNJrug6/BCIr+7VAkCnaMeK8NB8EmKeUNmo6pgBgzpLexiQrardLh+J7kq/pL
 kpaJR6FSoq/KZWSzWtpyHQ9r838IHznXZ/gd3O3j4h56wIsNKj1xC6N3fRBGoqGr1GAiwTAb1qb
 dOzLYzkIRXA4IlPIDj1CbJ0Lvf1y1Fis6k1vwl1Cz77RCpC4wa7/1uoB9S198DgNdoXvy+a/5QI
 oMezUW+nv2ob40fcPfwzr9abnCP5iFLv/OINnqBukVW8iUUCjreXiHUuLpBflRfZD2ia/9uLqpa
 bHzvuymCdM0rkJg==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based kernel configuration guards.

Link: https://lore.kernel.org/all/20240716180010.126987-1-rgallaispou@gmail.com
Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/usb/dwc3/dwc3-st.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index e16c3237180e970c184dfdb147c8abd46ff429a3..ef7c43008946e15b72d88aba4941dc52bf0788d7 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -309,7 +309,6 @@ static void st_dwc3_remove(struct platform_device *pdev)
 	reset_control_assert(dwc3_data->rstc_rst);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int st_dwc3_suspend(struct device *dev)
 {
 	struct st_dwc3 *dwc3_data = dev_get_drvdata(dev);
@@ -343,9 +342,8 @@ static int st_dwc3_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(st_dwc3_dev_pm_ops, st_dwc3_suspend, st_dwc3_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(st_dwc3_dev_pm_ops, st_dwc3_suspend, st_dwc3_resume);
 
 static const struct of_device_id st_dwc3_match[] = {
 	{ .compatible = "st,stih407-dwc3" },
@@ -360,7 +358,7 @@ static struct platform_driver st_dwc3_driver = {
 	.driver = {
 		.name = "usb-st-dwc3",
 		.of_match_table = st_dwc3_match,
-		.pm = &st_dwc3_dev_pm_ops,
+		.pm = pm_sleep_ptr(&st_dwc3_dev_pm_ops),
 	},
 };
 

-- 
2.47.1


