Return-Path: <linux-spi+bounces-11668-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6302CC9449D
	for <lists+linux-spi@lfdr.de>; Sat, 29 Nov 2025 17:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2137D3A4FBB
	for <lists+linux-spi@lfdr.de>; Sat, 29 Nov 2025 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562D61D86FF;
	Sat, 29 Nov 2025 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mCBWIcdE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CFF30E84A
	for <linux-spi@vger.kernel.org>; Sat, 29 Nov 2025 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764435510; cv=none; b=opSC2ptD0LbROMjZWs0C9lNvT4rf9WdHJnuAy2BPyVQ+XPCiaKeULyvEwokCEnY8WdvzlwJO90AJutNuptnATkylotysSH/XlkefOIdI0vVSccpBNU9KptYaigaNLVysbuXv8qz8A6PUQGt9tbC2BA8c/KRNOtOpNLh1l8jGYew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764435510; c=relaxed/simple;
	bh=bDsWyBR13GvWu/KmngbVucApNNubltw7ubiPWxdkZ7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ko1vfyQe6qwt/q7pfddpiGLE0RsEux4qUpk/CxV7aTXd4U4ULbhjn98KKS7HBG49tDIlnxDcr39eoEhKs+q2nvRs9D00vvs6+VbdV9Ky6B9ZL9xzHAps6B+oAOmvqQAirxh43me0rC8EaMDEqMdbCd3bWDlUZtEXVCRIxVSU2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mCBWIcdE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so4839785a12.2
        for <linux-spi@vger.kernel.org>; Sat, 29 Nov 2025 08:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764435506; x=1765040306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hrGw+j15exTZMybruW35jjRgEf4ik1Id5jv8eW56WZo=;
        b=mCBWIcdEfx2WG2p1Ut6jDnlvbI8O0m6XRxx3i0bhbr7iKDBdNyGwId6Zej2fJDvISI
         RV//vzJmG6bgWfRlwpuQMdx4WP9TSxydTvIgWpw7LU7HIRQKLqyKUAcDld1FExB0p/C2
         o0die17cXiZpZE0EJ0vqg8dVyOc6rVOldMPnR2zmxIZ7DKyMdoKxxBbFXH0sn/DP1R22
         I/bOkyg17sppPsiVUJgxWZjYzN2yo7RjU0zmJFPK5va1LQYcWNqZ3684i7Bsnr4wwXh4
         XAXAZOZS7NUfROC2zH9zO46pNvmt9WcPpuragQSRoik+SRIPEMlHN34g5umwqON5bRpz
         kUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764435506; x=1765040306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrGw+j15exTZMybruW35jjRgEf4ik1Id5jv8eW56WZo=;
        b=mf+zTgg83zAq2wHvlic/XELMqXoVc/swQNQF/7byG+RKaPDrDmJ3OU0nsya7N2J+DA
         nvm+YsU+MzmiBoOrgu6OycMGo0MMOvilbZYkX7dmmzb9Y2UuNmdPOgQXKGjSVOOK1l4A
         uOnUQBGU2yPJ+B8abzc7m4chZkr1Fld4wnwSYNE/vz1qcbUxjIy1JipDh7/pwRwOKKIA
         qk0fDQoOELKwhKAHY+MNx2YzJW33rHamIgSZpsbMFFdgOAU8oKgSxapj7woC/NGVLqD/
         9jRYUpaUdQfJHr3EW9yach2Y5pYtZjVXTCVuJ40BT8zXDzUlJ/QZkcu8tmWF9RWtf/tH
         eEiA==
X-Forwarded-Encrypted: i=1; AJvYcCWmf20bYwdyNaQBA5EjIeXt8W1RrJp0ttklAfusSBgFxuFSltYxUjtX8CPrdBWd9k1QwXxIOMv7E2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyse9W9w1rC5AH1I5JPlR/GBJ1hvtGe41bwNhxrsqHHj2nEWU5L
	5i5ihL8iEB+Pj3wmo6JhNzphMyEnNz5PH46r4tRiigE+aJ8nrj1yN4N80x/H2palFNg=
X-Gm-Gg: ASbGncsVKdbacn67KBarl3AU/CShMcDZkswcOZM6WG/hJYW3xURr5LEloskXxgZnaLb
	jsBrX5UEixCfDGbzzMVIux/N3/QkARwslbylv8xwEP0dMg+lvSbiJ5rHrZ1rw0Vw6QjHki+Eu8y
	pYkIYBlBuDjfUBCBRBLvG3S9rLQ9D6xYcnq9bvi34UuwlFEkYvx2vCdb3aEumc1ItTxzu3A7iZh
	dbhybbQZXRS7fZZjwBDtAPC4UaSykjJuPtFr3hTjCPCEOXSpGljRW4a1PDqAHJztBCgkiUtXgA4
	fbXyUPKG6PdnBFjnHt11E6qqEblykgGm5n2Umr/mvID8QBmdeGVppQJnQpmGyjdbLDay1+xfzUI
	WeLuHDDen3WPT0odlqDorRKP5mmdoifmzVlGbwqoNR/C9eziecIZ1ZDE+5sQfOReFFuW/qV2T50
	3Kb0xoOtCvwe0RoAz9
X-Google-Smtp-Source: AGHT+IFRiVsXHgKH32e2UUxbjoTC/2PC7We5ekSkNgMfKep0WFlMYzP0czf50nd3+3LacbL9BeDIfw==
X-Received: by 2002:a05:6402:4303:b0:641:8908:a558 with SMTP id 4fb4d7f45d1cf-64555ce53famr28532296a12.25.1764435506020;
        Sat, 29 Nov 2025 08:58:26 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-64751035b75sm7855980a12.20.2025.11.29.08.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 08:58:25 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Eddie James <eajames@linux.ibm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Ninad Palsule <ninad@linux.ibm.com>,
	linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 00/12] fsi: Convert to bus probe mechanism
Date: Sat, 29 Nov 2025 17:57:36 +0100
Message-ID: <cover.1764434226.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2312; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=bDsWyBR13GvWu/KmngbVucApNNubltw7ubiPWxdkZ7M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpKyYDXD6ueszNupCnGqcfTiYcaAFXAHx2f88f8 GEAG9h+7qmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaSsmAwAKCRCPgPtYfRL+ TuhOB/92oKD93snOWUjZjmay296pHDljAXCv9DtM027PRml5LWq3M0af8Kj+NHrNziZTYi9OnLA x+vKqFlgI7y+IYai2tZ7WLp4FR4DMXt9Q0ryxJ2FRM5r5vinjrLG6cQLOuU4w5NSruILS1SLnKe rIt0fyaMEDaE4KQaOdgp2S3zrw/W9lmkrrLSICTHmsGi3KK5wzu/aEGbXqvHd1dG1O3Dmy46LDh E4RGQJEBIo/Buq637M3fDlh1uY2VYPplZM+hojib+vWBlOrz0UKDc8Nb7W+/4Ogii/3H818BwJ0 vSZmGJk+HIskyOhodyP0BkQpu0ygHrqTw2sR4VL9cn78vHRt
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

for the quest to drop .probe(), .remove() and .shutdown() from struct
device_driver, convert the fsi subsystem to make use of the respective
bus methods. Some cleanups are also included, I noticed those while
working on the conversion.

Regarding how to merge this series: There are two drivers touched that
are not in drivers/fsi, namely drivers/i2c/busses/i2c-fsi.c and
drivers/spi/spi-fsi.c. The easiest would be to merge this series through
a single tree because the i2c and spi driver changes depend on some fsi
core patches and fsi_bus_type can only made private when these are
applied. I tried to quickly resort the series to only need three steps
when merged separately, but this wasn't trivially possible, so I hope
Andi and Mark give their acks to merge their driver changes together
with the fsi core changes in one go.

Note this series is only compile tested as I don't have a machine using
the fsi subsystem. 

All the calls to get_device() I found in these drivers look a bit
suspicious and I think there are some issues with lifetime tracking. But
I didn't try to address these, so I'm just mentioning that here.

Best regards
Uwe

Uwe Kleine-König (12):
  fsi: Make use of module_fsi_driver()
  fsi: Assign driver's bus in fsi_driver_register()
  fsi: Provide thin wrappers around dev_[gs]et_data() for fsi devices
  i2c: fsi: Drop assigning fsi bus
  spi: fsi: Drop assigning fsi bus
  fsi: Make fsi_bus_type a private variable to the core
  fsi: Create bus specific probe and remove functions
  fsi: master: Convert to fsi bus probe mechanism
  fsi: sbefifo: Convert to fsi bus probe mechanism
  fsi: scom: Convert to fsi bus probe mechanism
  i2c: fsi: Convert to fsi bus probe mechanism
  spi: fsi: Convert to fsi bus probe mechanism

 drivers/fsi/fsi-core.c       | 107 ++++++++++++++++++++++++++---------
 drivers/fsi/fsi-master-hub.c |  17 +++---
 drivers/fsi/fsi-sbefifo.c    |  31 +++-------
 drivers/fsi/fsi-scom.c       |  30 +++-------
 drivers/fsi/i2cr-scom.c      |   1 -
 drivers/i2c/busses/i2c-fsi.c |  16 +++---
 drivers/spi/spi-fsi.c        |   7 +--
 include/linux/fsi.h          |  13 ++++-
 8 files changed, 125 insertions(+), 97 deletions(-)


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.47.3


