Return-Path: <linux-spi+bounces-5685-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9BB9C5289
	for <lists+linux-spi@lfdr.de>; Tue, 12 Nov 2024 10:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D74FB27335
	for <lists+linux-spi@lfdr.de>; Tue, 12 Nov 2024 09:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25571207A14;
	Tue, 12 Nov 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FgmbyWwQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0B320D4E7
	for <linux-spi@vger.kernel.org>; Tue, 12 Nov 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403981; cv=none; b=R15izVRY+5NyF2tjTS9JFxi5O6v2xont2hDeNsPzqYNg0SyvhW3KD4lDl8LUWwe68jXPc09qbpml9ssNoSNBTXVaTl4JQVXrlIBx+RhUtcB7ppiznh8acc0nZN4fPZvWXd7tnscBRqBXEcG+6kj5jP9IadMwRAW3R4SxjddFexM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403981; c=relaxed/simple;
	bh=6ulFNlyNv465CkSpnCJx0vrLZRT7gA32WIk91lhQkA8=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=WD64zw+FjZeAPPJNAPmDZ/H2WAGb3tUkb3/kyVOC8Ego0HL/CgqZkUX1SNmjb0of/eFdmh9UkPINfgySewXQZlSMaOOnvF79h5ouUiHmN51WMLClxdckapLQcFzI8hPFHoaReK+6REfZwksCJqA4q6LQ7v+J3Lk3GqQPmP+Sm0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FgmbyWwQ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f72c913aso9362909e87.1
        for <linux-spi@vger.kernel.org>; Tue, 12 Nov 2024 01:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731403977; x=1732008777; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dhi4LfKU3ipkwc8NywPImwQqvqvfcH47W144waGwl8=;
        b=FgmbyWwQ9o65CKBp0ZzNrzfWKPF0uXnjG8bGZ0UeoWC9JkxBiN7QSm4ty/7Y5JizKy
         9CsUhEvK6S+zrE4q/vBWl7NPTe2ZAjtMb/ce7/zCsTZVIaeLpPg3O+XLkjXcv+DrVKBm
         UbdnGyeXv3VEUGYAkkwILBSu3dkVLd5mrv1TBmhriqoPSIO7KBdvS+EPBDM5EXm05J19
         ozxCxKO1AY87By82RbPvcUvijEmVf00QfuHiowakqYzGdjIeGHhY1mdkkyXBaLH8xorR
         U3EEmPS1BOrKg+Pp1l1O4OJfz4+29c+17bOMmJ2SKOCaczfe8Rk7E+egq87th0f1Epsm
         mR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731403977; x=1732008777;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/dhi4LfKU3ipkwc8NywPImwQqvqvfcH47W144waGwl8=;
        b=Kj0BcFcs7e9PPE3/+Eg0AQy7ZRtpjpMxDuGjEMERJjYBjpoHHn64zICv0cCKONcpie
         5mU1/UGOirKpfQAoIQR7x/Kpjq3oTncjoE/IH2Y7LQF8RTrSiB0YGKUECkDbj0jSZGbd
         6Hkc3K5cUKPd1BCiItR9PlCl9sSnh8JM4542ovl7tUDoQWB6riazfvFBmUT/PxvTaFtG
         psbCDbpvMfu57aoUTYeD2lILyjeoVQqIjcc9FKJcvLaj421OhLHSAx1rMb/gS7a50V9E
         nAZG3FKQvTtIng/JHr6rV6UgkPc/ypJEsjQFbgYU7SU0Tz/weIV4n8iwVTqJ4BDK8yIp
         zC3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUj4Hd6KyRc0OfVrFm7zg5dhxVp2YUDY7K/CTJ/I6DgTbYhNi+kkDndM1LDM8j/TINvx/nu3rG6zt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZofjO5QL8OZ0xMnRDb1n5TXzudZXsVUW7IB9wV4VwMkYz3wDw
	QKhA8iRPru290V8C/aHwEf7iUf7Yp1eZQuN2neBHbaxODPP1U/SRV2Y5QOAaRLk=
X-Google-Smtp-Source: AGHT+IHRp2bDx3H/YnbEHx56PZp7Niz36cAYZ3sBhFurqZsEqELAEZ5g9IxMMtCuhlrB2T4yeezGcA==
X-Received: by 2002:a05:6512:1045:b0:530:ad7d:8957 with SMTP id 2adb3069b0e04-53d862f7e1amr7186226e87.49.1731403977169;
        Tue, 12 Nov 2024 01:32:57 -0800 (PST)
Received: from [192.168.0.62] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97e62csm14825855f8f.37.2024.11.12.01.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 01:32:56 -0800 (PST)
Message-ID: <2d182f21-9766-4c05-8b97-786af69666a0@linaro.org>
Date: Tue, 12 Nov 2024 11:32:54 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 "open list:SPI NOR SUBSYSTEM" <linux-mtd@lists.infradead.org>,
 Mark Brown <broonie@kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: [GIT PULL] mtd: spi-nor: changes for v6.13
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

SPI NOR v6.13 PR includes the mtd/spi-mem-swap16-for-6.13 tag that
contains a patch for SPI MEM and one for the SPI MXIC controller. I got
Mark's approval on queuing them.

Thanks,
ta


The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
tags/spi-nor/for-6.13

for you to fetch changes up to 98d1fb94ce75f39febd456d6d3cbbe58b6678795:

  mtd: spi-nor: core: replace dummy buswidth from addr to data
(2024-11-12 10:31:17 +0200)

----------------------------------------------------------------
SPI NOR introduces byte swap support for 8D-8D-8D mode and a user for
it: macronix. SPI NOR flashes may swap the bytes on a 16-bit boundary
when configured in Octal DTR mode. For such cases the byte order is
propagated through SPI MEM to the SPI controllers so that the controllers
swap the bytes back at runtime. This avoids breaking the boot sequence
because of the endianness problems that appear when the bootloaders use
1-1-1 and the kernel uses 8D-8D-8D with byte swap support. Along with the
SPI MEM byte swap support we queue a patch for the SPI MXIC controller
that swaps the bytes back at runtime.

----------------------------------------------------------------
AlvinZhou (3):
      spi: mxic: Add support for swapping byte
      mtd: spi-nor: add Octal DTR support for Macronix flash
      mtd: spi-nor: add support for Macronix Octal flash

Cheng Ming Lin (1):
      mtd: spi-nor: core: replace dummy buswidth from addr to data

Takahiro Kuwano (1):
      mtd: spi-nor: spansion: Use nor->addr_nbytes in octal DTR mode in
RD_ANY_REG_OP

Tudor Ambarus (4):
      spi: spi-mem: Allow specifying the byte order in Octal DTR mode
      mtd: spi-nor: core: Allow specifying the byte order in Octal DTR mode
      mtd: spi-nor: sfdp: Get the 8D-8D-8D byte order from BFPT
      mtd: spi-nor: winbond: add "w/ and w/o SFDP" comment

 drivers/mtd/spi-nor/core.c     |  5 +++-
 drivers/mtd/spi-nor/core.h     |  1 +
 drivers/mtd/spi-nor/macronix.c | 99
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mtd/spi-nor/sfdp.c     |  4 +++
 drivers/mtd/spi-nor/sfdp.h     |  1 +
 drivers/mtd/spi-nor/spansion.c |  1 +
 drivers/mtd/spi-nor/winbond.c  |  1 +
 drivers/spi/spi-mem.c          |  3 ++
 drivers/spi/spi-mxic.c         | 17 ++++++++---
 include/linux/spi/spi-mem.h    |  8 +++++-
 10 files changed, 133 insertions(+), 7 deletions(-)

