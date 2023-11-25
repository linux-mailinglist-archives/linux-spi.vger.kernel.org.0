Return-Path: <linux-spi+bounces-40-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24147F8FE1
	for <lists+linux-spi@lfdr.de>; Sat, 25 Nov 2023 23:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB941B20CE0
	for <lists+linux-spi@lfdr.de>; Sat, 25 Nov 2023 22:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2401D27705;
	Sat, 25 Nov 2023 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bigler.one header.i=@bigler.one header.b="hKOLvl5w"
X-Original-To: linux-spi@vger.kernel.org
X-Greylist: delayed 360 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Nov 2023 14:50:40 PST
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368E0FE;
	Sat, 25 Nov 2023 14:50:40 -0800 (PST)
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4Sd6Nk3mMTz5yvD;
	Sat, 25 Nov 2023 23:44:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bigler.one; s=key2;
	t=1700952278; bh=FZNJP3nxNUKEIuONIbATOwCDJtkvy7ja6YZOXoIHlqI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:From;
	b=hKOLvl5w8rs3sYDDko7hym+l9R1XT11TFAf1Vl+hbgrEJkcFQoTVRSHAPDXJ3QOQf
	 Hedbm47b+0oESJEnawSEzTA3XCoGlsO/nJ3z0elqlTK+KEAvZOXGai3XXhQIQaK0aP
	 SCdQYE2csjVATGJgRnSDhRjCt22jTjgJTp30vN4boNRMxkhXXlHipYVpmPocun58Sd
	 wBra2CxGVpxz2hTVFxzGJIu1S7KzXYPxGA6XlcLcfHxGhT+CFiixp4+pU46UlJ+M8/
	 f/o+XYcIPzpSGG9Pib6Etq20elfJ4iW/aTFPTZmu6m5Zgh3wOdWzbDZp3EKr++RTXG
	 T+Cy2DR2UE5Dw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4Sd6Nk32dxz4w70;
	Sat, 25 Nov 2023 23:44:38 +0100 (CET)
Received: from mx2fc6.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4Sd6Nj585yz8scr;
	Sat, 25 Nov 2023 23:44:37 +0100 (CET)
Received: from [192.168.1.24] (xdsl-188-155-37-14.adslplus.ch [188.155.37.14])
	by mx2fc6.netcup.net (Postfix) with ESMTPSA id C3FDA45338;
	Sat, 25 Nov 2023 23:44:32 +0100 (CET)
Authentication-Results: mx2fc6;
        spf=pass (sender IP is 188.155.37.14) smtp.mailfrom=benjamin@bigler.one smtp.helo=[192.168.1.24]
Received-SPF: pass (mx2fc6: connection is authenticated)
Message-ID: <d795999676663a576f12f07a7013bee758fb781c.camel@bigler.one>
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
From: Benjamin Bigler <benjamin@bigler.one>
To: francesco@dolcini.it
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org,  linux@bigler.io, regressions@lists.linux.dev,
 stefan.moring@technolution.nl
Date: Sat, 25 Nov 2023 23:44:32 +0100
In-Reply-To: <ZVsyVAapXTWnznFd@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-PPP-Message-ID: <170095227324.806.8324255313749551391@mx2fc6.netcup.net>
X-Rspamd-Queue-Id: C3FDA45338
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: 2ksQ9lJvOoisjgPJEMFMloG8LvydxyFtO4QBLzOvLWrCGO0=

Hello,

I'm uncertain whether this is the appropriate place to respond, but I
am encountering a similar issue on a phyboard-polis-rdk (imx8mm) with
Linux 6.7-rc2. My system uses the imx-sdma firmware version 4.6.

The problem is with the TPM, which fails to function correctly,
displaying the error message:
"tpm tpm0: TPM in field failure mode, requires firmware upgrade."

The issue is identical to the one reported by Stefan. It can be
resolved by reverting commits 15a6af94a2779d5dfb42ee4bfac858ea8e964a3f
and 5f66db08cbd3ca471c66bacb0282902c79db9274, after which the TPM works
again.

Additionally, I've conducted the tests which Francesco mentioned:

> ```
> cd /tmp
>=20
> dd if=3D/dev/urandom of=3D4k-spi-test-data.bin bs=3D1 count=3D4k
> spidev_test -D "$device" -s 4000000 -i 4k-spi-test-data.bin -o 4k-
spi-test-result.bin
>=20
> dd if=3D/dev/urandom of=3D16bytes-spi-test-data.bin bs=3D1 count=3D16
> spidev_test -D "$device" -s 16000 -i 16bytes-spi-test-data.bin -o
16bytes-spi-test-result.bin
> ```

The readback data is correct but on MOSI/MISO there are 16384 bytes.

Please let me know if I can do some more tests.

Best regards,

Benjamin Bigler

