Return-Path: <linux-spi+bounces-6199-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258429FDCD5
	for <lists+linux-spi@lfdr.de>; Sun, 29 Dec 2024 00:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428113A139E
	for <lists+linux-spi@lfdr.de>; Sat, 28 Dec 2024 23:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6099B19F420;
	Sat, 28 Dec 2024 23:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTmrw5kT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7D319D8BC;
	Sat, 28 Dec 2024 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735428784; cv=none; b=mskkZmC4Th185F+DVhfP76jzoyMKfF+F4ylasBGjiI83AljcYiXDHPBQD71GdMlMJTK9Mg/gCQyJltiGFBDgtPMMemnMo+TyjTNSrPZL0UfN22Q0JdB5yfQZMGXruehsBCriyr86GQjndx5CG5BSPwDqXOnZo6tfW3Gup3yZ5mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735428784; c=relaxed/simple;
	bh=2SAyWje7KVs9u2R4zoEyduMFN1gU91zxKOMAXSN9WYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUSNOVNHOU59BfTW+1x+3aJU3WJSBcvDbBjARYbVPHi3DKPPfgpkEKevDX/oEyIzFSqmrNnJ2vIJYNK15nCdxVRD4iGXqzi4+t+NuVAoMfNoMKDY0AnOusu1bEteUsZwJ9djqdxHFwAZnPI0hGveLMTvvjKdT6yW5x5ZAjDQfio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTmrw5kT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so86680315e9.3;
        Sat, 28 Dec 2024 15:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735428781; x=1736033581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3zTfYTmH7V6QXuNHKkMZLGYqANdc4Kmp0yLfTvIJII=;
        b=gTmrw5kTT/t5wpHjKIFXGBV8YJNVtczGaBk4hnFjoIw5uVs98fPAssIZ3H5Ig94SzX
         OoFDXhHCjnl+n4pdOGUquYEUn/+AaB07dbCQ5hW0cZD9P7o7HWVBEv17FGlCJdlLN6zv
         d3/cjbPkLNZYwPjwWdGjfGRB1t3aQ2CnGyU5fRChqTkyek39tvEyii302sJV2yc54UXw
         iEAS2qgDx3atsr/cpUX0vJ2dmIffRk8bMrU9RUYBxLLgelmEYVnyJIf0CKZpHMomGjw9
         Dei32SYqd6JGEjYY2VcRUnHbu+W9g7UxysqsliV4UdyUBDKpHIWj18eJ3MJMUjn7VL6o
         +Uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735428781; x=1736033581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3zTfYTmH7V6QXuNHKkMZLGYqANdc4Kmp0yLfTvIJII=;
        b=XPXSp056xD20LNcOo2M5bIBnLobGqRladw2fkfA9Xiko+jDLOyxK4gcugi4wuAId41
         V9j5f7qMUyIAo5kyUZG/59vAneAhGO6lTfYS2bTMEHYb1elaUiXWioCrSGtGWG1fY0DS
         /G7QOw5Qe1Qye/xeoJUoz60B1nSs1X+r1UFNV1AwEPi1aMIxNTQXyrDLsSNjM9FQGoRj
         WUozRoGcwA4EJbDW3taPeEhqYngAxjkQI5yywPeoRLKdrgXYO3SEytUJxerWHULiEmht
         ivuFs+AOO60m66me1RBd9q1o4rD02n8sF/TYhuBR6fbL0zQJ0sj8MCvSldaDfTYYoIVN
         7YJA==
X-Forwarded-Encrypted: i=1; AJvYcCUPNrfP8J+09VA6qna5SWYPNWp99c/whur3UpEYQzqh6fUWWqmYZ4U0cn/RPzUm+hxZv3neC19j@vger.kernel.org, AJvYcCUR3w1Ggtw3WFS9+A8cryTa+tQPDU34kgrYRj8ay7SDWvKJRe0RF/dQnZeUq8LlNe725ISeCqMLVhw=@vger.kernel.org, AJvYcCVOiWZmv6Op4UhHStOoU14ixatpCuY0Cy6sucivZ3HupYqHfql42yFiVBioGeSFqiJO+B7lG6JIxlTu@vger.kernel.org, AJvYcCVQYEXc9+kbctL58H5pLDHOCr2dzyEmiwYZagQxuFRV24JRrLAGFHTKvxXXqHmrE2auDTdybHEn79Mc@vger.kernel.org, AJvYcCW36u8vrSXciDgB0Q2237DppgSU64OEJmpPP1X7/BX47Tsxe3jN2OIK/Ku8GD8bclLaot7cV7ErArrH@vger.kernel.org, AJvYcCWy4R5+Au5NpLoCiPc+NmMICS60uMz4dNrCdQgZnkyaRSsKGYscc7BfavagxhY5JJQ6TkGLoCcg8xtB6rHK@vger.kernel.org
X-Gm-Message-State: AOJu0YzXvRzrUQ7JS8TOiPxmQCZ7OFHkadn15co0qR0oxkozlBV5A9tU
	FeJ/jYkjZ9rJyGcnATSaqM0+HnKG5+MADT5PMKP4WOYgLeC/N8F9
X-Gm-Gg: ASbGncvzWW3mKAUxeQJFZauc/Kjsr5N3KBZJ8c4FWduNoBSQpz8ByxYX8GU5M98qb8z
	awM3zTNGfXYju+CQf5EUgdmoODyYx5+eqbSZmDBZIKe6WHoqALhFWEpKFelwsrYlzMFjtglBrU/
	wQ1PnMll+iE3gN2S+dlmKKLEr0ragChvl5tZJCYLrckGTi0wDIectW+gdge+4VJH5tOOKwMChEi
	yAXBN2rAClHDY9lptufHhMocR7m1pLRGW3Dvv4JKjofxzJIHD2tLi4xxQ==
X-Google-Smtp-Source: AGHT+IEcJYHmTXyjTQ0IKDccCfhouFmdjCPXPJuqVdFHdCEXf871k685aGmx4Gh0Y+WbNAty4FI1JQ==
X-Received: by 2002:a05:6000:4021:b0:385:e4a7:df07 with SMTP id ffacd0b85a97d-38a223f76a3mr28191587f8f.42.1735428780424;
        Sat, 28 Dec 2024 15:33:00 -0800 (PST)
Received: from localhost ([2a01:e0a:d9a:4c20:d6da:7147:f20e:31de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c4b0sm309653465e9.35.2024.12.28.15.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 15:33:00 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Sun, 29 Dec 2024 00:32:45 +0100
Subject: [PATCH 6/6] spi: st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241229-update_pm_macro-v1-6-c7d4c4856336@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=2SAyWje7KVs9u2R4zoEyduMFN1gU91zxKOMAXSN9WYY=;
 b=owEBbQKS/ZANAwAIAechimjUEsK1AcsmYgBncIqlgyp8ozEWbmqkXK9N4hLvauXPgVgz8iuIX
 xBtJUtexBuJAjMEAAEIAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCZ3CKpQAKCRDnIYpo1BLC
 tQjtEACgRG4xlJ7uKeIA7lnM0soMV6YFReYT4AAeQKOEdIX+sJjm1B/RWvmEgjXHXiMS6i/olGb
 tdDopgx+J7oOsCT66udg8iNHBKWlKb/czzNYxNoGUk7ot5nUdnl3Bpi4D04kQrhx0LX+BMyTZ1s
 +tUcKBW2RH7Kjv2vjN1o/ibE7G6bNCGaBwQGTQ9bQd4lxohl9pKtpGmSYvHzpKodw074qMs+YdT
 z4kVd89fIMpy7xqvrsFb27UR/VRPP8IpZ02niz+kXpcXaEQaVz6Gexv+T/QlM37+ep/oXUYpFEz
 wl2lxWo3Dr87Xr1tl8nkk9R+1KGlQXOCm+jQOBA5Glz7qtPq9KyckYmCnaioNMg4QZ1dJKjgN8E
 BP0o+AKr2SsiZrlB0eG59j0BtjMzxcHcTjtCqqc9eLfL3QxRkjDnRXslWdHYjK3xarvL4qoWFnc
 5SoEnxWQAzlBUlnMQbMz+rvUOBgBf2CkbJL00q/21GlSPaafulA5Ir3UE8ZutbThESAmOb3YCCC
 7KICCYh5ru3stSIk3v57JjCGG8OmoViMTw9TdUI1I57+KNmiSlNoC84LUAqRsXLEl2kHrXrPH46
 0b5vWiZUeMOn33qDrFPEiGuHlzP3BcA0M7IwZNPW7nJ1rhQ6H9dkT9dR3nF1MtJg2X2Orpw5FsW
 Ww6pQALy6v0aVTA==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based kernel configuration guards.

Link: https://lore.kernel.org/all/20240716180010.126987-1-rgallaispou@gmail.com
Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/spi/spi-st-ssc4.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index 4cff976ab16fbdf3708ab870176a04f2628b501b..5cc452447410bedf3c12893d94bc959892ac827d 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -378,7 +378,6 @@ static void spi_st_remove(struct platform_device *pdev)
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 }
 
-#ifdef CONFIG_PM
 static int spi_st_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -403,9 +402,7 @@ static int spi_st_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-#ifdef CONFIG_PM_SLEEP
 static int spi_st_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -429,7 +426,6 @@ static int spi_st_resume(struct device *dev)
 
 	return pm_runtime_force_resume(dev);
 }
-#endif
 
 static const struct dev_pm_ops spi_st_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(spi_st_suspend, spi_st_resume)
@@ -445,7 +441,7 @@ MODULE_DEVICE_TABLE(of, stm_spi_match);
 static struct platform_driver spi_st_driver = {
 	.driver = {
 		.name = "spi-st",
-		.pm = &spi_st_pm,
+		.pm = pm_sleep_ptr(&spi_st_pm),
 		.of_match_table = of_match_ptr(stm_spi_match),
 	},
 	.probe = spi_st_probe,

-- 
2.47.1


