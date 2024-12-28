Return-Path: <linux-spi+bounces-6193-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA69E9FDCA8
	for <lists+linux-spi@lfdr.de>; Sun, 29 Dec 2024 00:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8F03A0713
	for <lists+linux-spi@lfdr.de>; Sat, 28 Dec 2024 23:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B165513B280;
	Sat, 28 Dec 2024 23:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CM508kJj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10FD79F2;
	Sat, 28 Dec 2024 23:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735428777; cv=none; b=IcJZu9ceirzmPDUfyFJ9JGUYxUUqRSkM4weOXIj+YVtmuOh0/iBKz8jhsQEvjnXldEHjnctjSFZEWtB3Yrg14xvEJYJxCpt8qHFpYU/TANUl2QUGPixHwqwcTLnv7rDMgfbelADNAv41FVg3Yllf1tJfOUoG4HasntMgVsBWz8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735428777; c=relaxed/simple;
	bh=giHUQnI8ap63UVqjMPzoWtpyquzmfVZTDzUG6P1RK5Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ad+q39d6w3h6oK041Y55jefRIvXK3etAdOnfh9gaKOj5DihEnUcXRJ+R3RIBLbQahTPU8B5UxpcYyl+RrE5K/5RsNu5eZKkiB++xY2RK9yP0N7VDuqBfMW/563wUkqq5+Ojmo3SFhsu/dKNn1dIKnqIoqCRzqvMt78ntgPB67gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CM508kJj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so4239971f8f.1;
        Sat, 28 Dec 2024 15:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735428774; x=1736033574; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yp6YLaS3wbdHHh56yyPBMz3HOcQbYn0L1NBzbosE89U=;
        b=CM508kJjNjXIsAXSgtZ6AO+zM4k6oahUSTYUUgOGZO4+VMUhkLv2JgvLE3LN8jDss3
         WtG0sE/OEWmOCMa21VvwQ7XhPAUUX8CsjlV2Pqw9TrPyhybcN8WXundE2R8rsFkJriZ4
         pEmW56RnSqg0/0qm0upljdx77ynB5piNOcuLvrengMDLJUUh5UZs8qZhmzciIWRfuViY
         TLv8ImOqb+/kSduJq5pXVC2XG0G6QVBI21IRC5CzeeHDRqcw3TSLz4K0QkiAiPEo3hI2
         vbRvHRf++LIlEKDZkafqOac6Lc6Re1dhsv/2TtVjAbWtBY7LicGQp5sN0xCLyK0zmRnF
         FXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735428774; x=1736033574;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yp6YLaS3wbdHHh56yyPBMz3HOcQbYn0L1NBzbosE89U=;
        b=oNJAh2cNTsjW9E5+HanRgyasOmsD/HzKWz0RvK2GtStxjQb23sif19R1RoyPN5Dc0C
         Llll45nu4Vc1VLZjpK/Ej+vX7bG6wOyr/VjVUU5nyokPrT7JjbsONIm1OtDXDsGtVRVD
         t9rKQyIGLf0fjMBxaDNIIvxaoA5pbzqO+2UIJidPxH9xLPxgInFfhPh4vrxmnl9F/+Lh
         KR9O+bcXDbEbVrvvhmCccm3+iea51TlBMmIaYs7EveoAyeOYdCl/7AI5ObiakWvge8Wt
         Y0lLY9jIqIizNARUWm9jARA/W98T/2SVw1pAVLW1s08H0mb5zDbH+FsrDj9k+QG3WFkE
         ryYA==
X-Forwarded-Encrypted: i=1; AJvYcCU7TEil1wXEHBbOmGgCjYEz7uGQfE8KO4wMgKAAFlOwqHfxQ+FU3hJSlmruoTEoGjatpsyEIIaECAs=@vger.kernel.org, AJvYcCUuedyLS/caQwNO0bZpR3Sd689ATTqe67cp8KG4pvPoFL/65namBqGZ32QxRQT3h+XiciGo8B9+ZQys4MFM@vger.kernel.org, AJvYcCVTz7muUy2XRKVvdsfigWWrbbCGUVNkgTZ4DCp+PNTKUOoO9hcvdjw9y3nX11qm7u59VaSfO2SZkdZN@vger.kernel.org, AJvYcCWZ1egePwwQJRL/jqWqFANVXKb9PFKQmZLjZ02L8KGticaoILdIepXupHfrHwAkD1hWhOAT1JG8CcTA@vger.kernel.org, AJvYcCWZw5rY01j9IQa9CGwFYBOAT452xMZWgkpV3BBTFLhvwgjvOwFQC/FWQcGdrmd24mZRHMz32v5V@vger.kernel.org, AJvYcCWiFbfGMCfPRGqR0k2RzHp0psc/Y3Z9u1d3qN70dsBKWtAiVNM+Nw+N/5/XGZwBb1EigodQOsS96ePL@vger.kernel.org
X-Gm-Message-State: AOJu0YxKc5QgUnCbzCNz/kB9156uF8l0yJmsDzHzCOqQkYfZZ1Rr3rQw
	rOOnb42KkGmhBXgUrgGxdt+wI4Aab4AirkcsLIqZu/gl3o+jKaTl
X-Gm-Gg: ASbGncvdkSnKjPrmtcidmoI3y3Y0E240Nk472hd/79i9QTiylxtS3+AJBJlxVBINMMJ
	g1SRe0hLi1YxTpnswc7axoU+1n3L1LrxzW89o5jVivGmNnlcUOKBhlAq8/JA7mFC0kreqSGvnm0
	8I6pGanxqoWGP3a0WXSbZo8gVMBq64wKeL5RJDIqG/DCKbJZ+ftNCybgiSts+14Y3GfZqL4LNu4
	9cy9MBoe7iqdJMQCePHLV6SUp8IIb2TV9UdbNxFBpWg6Hz0vEx15JxzAg==
X-Google-Smtp-Source: AGHT+IH9Pxly1KkOAngXtmnCTp49btuhnhudeYM8IucjVtpMMTrprdVjqVAvd4Ltow0b92P3+UAzuA==
X-Received: by 2002:adf:ab0a:0:b0:38a:50fa:d582 with SMTP id ffacd0b85a97d-38a50faf3cemr1893012f8f.59.1735428774217;
        Sat, 28 Dec 2024 15:32:54 -0800 (PST)
Received: from localhost ([2a01:e0a:d9a:4c20:d6da:7147:f20e:31de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8474c2sm25616331f8f.55.2024.12.28.15.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 15:32:53 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Subject: [PATCH 0/6] Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
Date: Sun, 29 Dec 2024 00:32:39 +0100
Message-Id: <20241229-update_pm_macro-v1-0-c7d4c4856336@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJeKcGcC/x3MQQqAIBBA0avIrBPKFKSrRIjpVLPQRCuC6O5Jy
 7f4/4GCmbDAwB7IeFGhPVZ0DQO32bgiJ18NohWyE0LzM3l7oEnBBOvyzlEqrWa0i+97qFXKuND
 9H8fpfT9Zpv3sYQAAAA==
X-Change-ID: 20241228-update_pm_macro-e4585beafd33
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=giHUQnI8ap63UVqjMPzoWtpyquzmfVZTDzUG6P1RK5Q=;
 b=owEBbQKS/ZANAwAIAechimjUEsK1AcsmYgBncIqaIFUIX99U52dYXyKTHv3kUYpiB1NgWDXmQ
 fbeWDg8/+6JAjMEAAEIAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCZ3CKmgAKCRDnIYpo1BLC
 tcMtEACBJ0gPdEh3A9kQDku4xnQ3prDDj0BroWFCemcZ3uDele37akkQ207mrAPUnUAf9Zjo6nc
 lFC566Wdx1jXko5eOVPaPJ/edqebt3W2r4sk2Y3mZcT6m2+MeO43BR2XfjjNXzSxDSYp6zSh0QM
 R0urFraGthT4o2d/WeZBebYnfPMfCemp8aA5KA3NDlRTDs0AdY8BNKiLKl2eaRuZno4DUuK2ibI
 zw8rWXkJHld/dOAL+sm+Z4L5PnkRFnUCDk/IXDiJuHWiYlKzwX7G2FP1s1r/fAIFg4rtm2x8wCo
 guwnv5TNvItP1xk1dOqmdxOqboQdx7O6Zxg6aE0iz/LFB0oU/cV0tTZJQaI1mg9LSJQqjF9tFiD
 ws0ugN8G4DLBVUJotARGmqBcWIyIzHZpP1u0UBpnM58l87bG1qK+9CLt2EnCUELhVgdz+QOqtfm
 mU6LioIYAoEFxMPlYDjFTK++GHJ28PO9vOfanD8WFpAIHbUrJJyWXXyI28hKfcBLOXPuxN5kmny
 YUc+xSr1t+hM1ger7KHjGW4dpzEpAOtWwYvYzk+WgMOn1vYeBqWC6x8LaEeN/qOGS+4ajhwrqj1
 c3PTO7zspLoPoHi7uMoGHkGtePff2MI9uzzYdWnKAQW3+iftKa3RtY8hFgxDar0iu0ldblZHZnB
 sISlnpXRGIpbxKw==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

Prevent the use of macros, and rely instead on kernel configuration for
power management.

This series makes the same change over six different drivers:
usb-st-dwc3, sdhci-st, st-spi-fsm, ahci_st, sti-dwmac, spi-st.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
Raphael Gallais-Pou (6):
      usb: dwc3: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
      mmc: sdhci-st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
      mtd: st_spi_fsm: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
      ahci: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
      net: stmmac: sti: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
      spi: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()

 drivers/ata/ahci_st.c                           | 6 ++----
 drivers/mmc/host/sdhci-st.c                     | 6 ++----
 drivers/mtd/devices/st_spi_fsm.c                | 6 ++----
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c | 8 +++-----
 drivers/spi/spi-st-ssc4.c                       | 6 +-----
 drivers/usb/dwc3/dwc3-st.c                      | 6 ++----
 6 files changed, 12 insertions(+), 26 deletions(-)
---
base-commit: 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
change-id: 20241228-update_pm_macro-e4585beafd33

Best regards,
-- 
Raphael Gallais-Pou <rgallaispou@gmail.com>


