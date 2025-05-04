Return-Path: <linux-spi+bounces-7877-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E183CAA862F
	for <lists+linux-spi@lfdr.de>; Sun,  4 May 2025 13:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F0D189A028
	for <lists+linux-spi@lfdr.de>; Sun,  4 May 2025 11:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5950A1A2C25;
	Sun,  4 May 2025 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf7Fdp65"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFB9A29;
	Sun,  4 May 2025 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746357816; cv=none; b=scWrqvdvxRg80TiuE1cOInfec7HXPOtaNNZh0jO97RCt9xYGQ1CLYvl1T+7inrHBI0YWW96EpATx425BM4QvjilJwGtuWVoC9y4WHr6fHF3w5UOlUhW6Ow7+p/uRoLJBSvxJEwgFe8tz2B4ASFvsgv0qW8PB8Du9ClPYScFv69I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746357816; c=relaxed/simple;
	bh=WpIr8GKgvtxyOEB1BvYudVvyTK1mg+FzKhOiCtz/vik=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nl0wBZZS2BzbMlkqCjCI2WyGbGUg3S+rm1NYQ6cKk0lUklP37odBXwHw817QhlYNrdeNO/IxuVd2h7fN1kZeYOudcRgzpKJ0FQWltZA+rXOnRq7Rsh4lKN5aN1IhRxPIAuQmolxURgRScRUWWAzgVEow5/1TVokXNHIU3e6/XHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zf7Fdp65; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394a823036so32970515e9.0;
        Sun, 04 May 2025 04:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746357813; x=1746962613; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zV8BrMTkzQFkPZ+3Fj6/O6YK38B+dAgJMFffx23ECvU=;
        b=Zf7Fdp65Bcl7+cARFKuwl3gTm42W7hWOdPORCKTQdYbvo/PjRqQrIhguWoBihP4zsX
         YiP3rrFudAUq+js6J3wHZdvFnf+w+j/ogTD9H0n+GDnFn7OE5TZrAFViZCK/Kq1gWU67
         fzxvf1J5JyqreDWkLKd/ixs5kFwZMD/bYi4kV+Kb/TjTs34gecDms/dHiIGzId/1aqIp
         ebGuS+eWKlR7aIcXHfQwPCyAT6vFhVheLpXaCMkvmJrmM0/L8rUt3CmkRn5si9Jcm5bn
         tjxe3lVytDUOJjC5Lilavm+rXHdzZjRE03JIg1WCUkDRK2OvOtbEecoGrEw58toSN7Se
         EdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746357813; x=1746962613;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zV8BrMTkzQFkPZ+3Fj6/O6YK38B+dAgJMFffx23ECvU=;
        b=gM21eUfTd5HpBNcAfIhO/D7kv0SIhmuaj/Xr42J+n5t5XuyPQ62eNMRy9wXtFV1UUY
         yKmw3oA9lJGNJDyr9LVb8eKqDaiw2iWX40XUgcfCGlyFYn1vmNbdwKgu2VFMEdMm4RfV
         S7zu19Xy2VaCa5oawU9FJLI0hBGLu/Ks0EpHbtEaJyouSchau/vJDbNtQxHNougX/eSD
         Y9AMtiq2j22BJZ63DK98k7dVNnPW4HWzpHJHrK9F7d7X/7dKQm3lweL9u57nHiB7Hkwf
         hRWLBnxMW/lxD6PVOyfbHocB2WmL0GFwEMUCc8oos1TJK1G6u8B23v3wDFoR43xR41KR
         j8Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUhoHQKY4/j+m2I3PZ7RqPwwQZEv4cuk9KPJlr9eDmsiDKM6GwVmgxOMqvW7P0cFuYu9KsL3GlW4dzmZfY=@vger.kernel.org, AJvYcCXarcyerWUiuv7t6fsgkPRvvJcrxukrsoizJMNvAnrUZ/OZm4jEFipNxoIMtrBWTKV5DpOJh7uKoRhM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/YUJb2CxZkH2Piu/RLLh1xgT0Ath3Wk86Vo1ULtGFMMnjv6hQ
	qyXehW8zsyuRNOQH8dzrjNamybQhD282jwOjV7z4H7msFQ0WBO4z
X-Gm-Gg: ASbGncsra5hBspbCFJklbQcU5UIP+47xtBtvf7h6ftpVhGFAP3lWDPhz6Nc4QHPLdWQ
	TuiMTfK003WKm9fle1Lt/v58Nq7M6rU67LM3l4iLictxPLj840uW+taxvgjjsS4AaDFlr1Wb0A4
	FWkCuBo/icEqwgvwwC62sM+6u66TVKeoww2nctPFQgvYeiyvuFtcQ00jgXwJS7SCFNEjPPu4Nd7
	vFJQHn0c6GfpelYVANCv/CVL6pRybidbqZObmcaHhWBW89Tv6QmQewYJ4f2nY9Hf6isbG/itlC9
	s9mDfQ1lbMRsEuSODggEl5REAhc7Zbww1Ajqlj5VGg==
X-Google-Smtp-Source: AGHT+IGYsFl3VJuIKwcSGexluz2hUMdp2LZdMlhpAn/whLRKwiXkBw5rxLWOPeRKFmWeJpA2mQqpeQ==
X-Received: by 2002:a05:600c:a401:b0:43c:f332:7038 with SMTP id 5b1f17b1804b1-441c7a306e5mr13926885e9.21.1746357812492;
        Sun, 04 May 2025 04:23:32 -0700 (PDT)
Received: from Red ([2a01:cb1d:898:ab00:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-441ad813a64sm149278145e9.0.2025.05.04.04.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 04:23:31 -0700 (PDT)
Date: Sun, 4 May 2025 13:23:29 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: ldewangan@nvidia.com, broonie@kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, linux-spi@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [regression] jetson-tk1: spi do not probe anymore
Message-ID: <aBdOMUhuUqbZm9w1@Red>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello

On my jetson-tk1, SPI do not probe anymore:
[    1.330681] spi spi1.0: Invalid delay unit 2, should be SPI_DELAY_UNIT_SCK
[    1.335185] spi-tegra114 7000da00.spi: can't setup spi1.0, status -22
[    1.341643] spi_master spi1: spi_device register error /spi@7000da00/flash@0
[    1.348637] spi_master spi1: Failed to create SPI device for /spi@7000da00/flash@0
I tested 6.14.7
The SPI probed perfectly in 4.17.14

I tried to debug a bit, and the driver requires units to be SPI_DELAY_UNIT_SCK, but it seems there is no way to set it.
Removing the "return -EINVAL" in tegra_spi_set_hw_cs_timing() lead to a successfull probe and the flash device appear.
But I agree, it is not a correct fix:)

Since only the test made it fail, I think the driver is bad since commit 810593668468 ("spi: tegra114: change format for `spi_set_cs_timing()` function")

Regards

