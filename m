Return-Path: <linux-spi+bounces-11078-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28709C3AD55
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 13:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62E6C350E85
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 12:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18100311977;
	Thu,  6 Nov 2025 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b="SFDA8/1Z"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934FD322539
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762431250; cv=none; b=d6vY84Xmr640moMDpd9ttgtzoLcqeo7odaKFsBjFDNJY0bAwt+/qwZcbljU5I9G0J3NDKCQCHTQNmduSdkD0OdbrD60woC1zwUdAbTmZajI5ntdNnKWVcwQAJ0+7sVxOdMlAYqv+APCvvIQgYcE81Jiw95cOS+ds4O7+88XzI0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762431250; c=relaxed/simple;
	bh=fzplUBQ1TkgorhfgO74WpZ8kentLZolTzQGZShPNb4U=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=EqjGy83V/JSCbhO4EGOjInlJP/KK3yDf1KH9OOtB+0oUvuOlI9p6vLuPlBe4dAstwi2V3ulrKHmV6CT8+Ldr1fmSJ7TiilRVytIiIrDIQV54fUXlpRbxbWCWLrOQVwu52t/giE5Dgi7pbsE8TkNr8HmNUbw3uYnh9Pujfps+H+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com; spf=pass smtp.mailfrom=hazent.com; dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b=SFDA8/1Z; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hazent.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477632d45c9so4822235e9.2
        for <linux-spi@vger.kernel.org>; Thu, 06 Nov 2025 04:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20230601.gappssmtp.com; s=20230601; t=1762431245; x=1763036045; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QSYWb0NRTBXDKlg4Kb6gETdOUX1f6YbkyhfSw+Zxemc=;
        b=SFDA8/1Za+uiNYD2AkIyASB5dHj4bZH8yufTOreBdSn0h92/OcOQaHwD3xBCoaWVn/
         gN4LZkSbT9gcS9xkX86ZJc4EMUbzA4D1+WYSYnbYtSao3gS532GeOrFRTST0JaYSt8X9
         caVQwEcTYAT3vNSfPKyTlNEtKkQFrCn/M1kNwlctSJPMYOB1dwQnfGS3QM47vLgfEAJ+
         R2oyzS697QyD5MIhV9NzVBb7HnU6jQyX6EFUKzu0thg0G0FGsf8ne4t2ST2mfaQuyDyK
         GYJ9PS8X21lD5YUrVRh4PkMSgKis3F7FCJWbyjAWVAgbFR6Ei3s77rfBZkcojq815NZO
         H7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762431245; x=1763036045;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSYWb0NRTBXDKlg4Kb6gETdOUX1f6YbkyhfSw+Zxemc=;
        b=QPn8s+HJu+nKbUrn/RaFk72IeFUW3fDdIVuWJ6NHFA9zxAzUHJ6BQ9vYutI952G1Xw
         JgKKz2CbU35Nksy+Stgjkh2nqnnORtN+Y2uGBuJeexEDBXVCpHt0Cde6wPIVic28baf6
         dlLwlxI094LoF1DpO1LlzE+4Ne//2+e+VFA0N5ICQARIDyJwxk//iI8m8xIMYLiJbKAb
         nU1qwjISEhPHHGpnBC7/vD8ko6nRsciFRChVZok/0uflRiuK7zo3Hhh0O7GoHu/qTl+m
         Dj8zBvGsKScoOuD5gvINx6plio/O0tspqnAzVMd3QemvFWrB/NCUFeyVGIl3jBQ1HgRF
         8N9g==
X-Gm-Message-State: AOJu0YwjwhQKlZTCyUlY7qZFmWBLlQ0EAB4Zs2t/WKnwCYkFZkZcphAE
	X0rOKWqZpwPrfP8obAGcUMw4MegSGzM0qLbF5DjOZRSlkM3KGkL8Tz5Y07/llDnzgNpUFeSJo7r
	VS0M=
X-Gm-Gg: ASbGncsJ41gSndUZJrOVrBn/qIz/oM5nZ5mG9fMtCMYog054O9sqO/syij80kD2cTOp
	Usn1yHwtAouwAEKNWSUzCxiTkt/fLou5wM5iPSpiY3FT94elC0F79DhA4v1cfJ8L66XWyAJVXI8
	ffz0YAFEBvqApgG2OkSlwTeiYiNvjD+zANkqU65KBJplnJodEJNNuCIfyjYWi7amErN5XzuhgAP
	EQFPS73z+sv0sDGV5Nz+Wae2D9X5MR3D2EuYknOKhTuvUxQKd/DXsK4MieQ8Tkzw19W+CSkL8vG
	4+b3oi4d5tEDNhfpa1hU/6uwN4q6sNUGGe+mOllUE0osWoZcvGwLa70BuV7TziuT4kYyWk48Tsu
	OGipY94xshNu7N1Vblgk9/lKRBamRq+yBz0wmi3jt0ggSNF7y8bz4i34am2zAAlK5tFSfU6ANyD
	BE5zVKhDdTOiHlSxA8924=
X-Google-Smtp-Source: AGHT+IGgduztHXwT7cOnOVfUCZEbdHh2VTwGYv3UL7miq1BrCjF+uqTMP+gdo8zQ4EAJtENpuYDByQ==
X-Received: by 2002:a05:600c:4514:b0:477:171f:65f with SMTP id 5b1f17b1804b1-4775ce32c9fmr47999585e9.38.1762431245327;
        Thu, 06 Nov 2025 04:14:05 -0800 (PST)
Received: from [192.168.2.3] ([109.227.153.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47761c2fe2asm48720625e9.5.2025.11.06.04.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:14:04 -0800 (PST)
Message-ID: <40ca72b63d52d2db4d03ed45d17edd1000290c3a.camel@hazent.com>
Subject: [PATCH] spi: xilinx: increase number of retries before declaring
 stall
From: =?ISO-8859-1?Q?=C1lvaro?= "G. M." <alvaro.gamez@hazent.com>
To: linux-spi@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ribalda@kernel.org>, Michal Simek
	 <michal.simek@amd.com>, Mark Brown <broonie@kernel.org>
Date: Thu, 06 Nov 2025 13:14:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SPI devices using a (relative) slow frequency need a larger time.

For instance, microblaze running at 83.25MHz and performing a
3 bytes transaction using a 10MHz/16 =3D 625kHz needed this stall
value increased to at least 20. The SPI device is quite slow, but
also is the microblaze, so set this value to 32 to give it even
more margin.

Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
---
 drivers/spi/spi-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index d59cc8a18484..c86dc56f38b4 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -300,7 +300,7 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi,
struct spi_transfer *t)
=20
 		/* Read out all the data from the Rx FIFO */
 		rx_words =3D n_words;
-		stalled =3D 10;
+		stalled =3D 32;
 		while (rx_words) {
 			if (rx_words =3D=3D n_words && !(stalled--) &&
 			    !(sr & XSPI_SR_TX_EMPTY_MASK) &&
--=20
2.49.0


