Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4616131B05D
	for <lists+linux-spi@lfdr.de>; Sun, 14 Feb 2021 13:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhBNMgD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Feb 2021 07:36:03 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:39149 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhBNMgB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 14 Feb 2021 07:36:01 -0500
Received: from [192.168.178.31] ([88.152.184.104]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MBDva-1l1wvx1vt0-00CmEm for <linux-spi@vger.kernel.org>; Sun, 14 Feb 2021
 13:33:27 +0100
To:     linux-spi@vger.kernel.org
From:   Markus Koch <markus@notsyncing.net>
Autocrypt: addr=markus@notsyncing.net; prefer-encrypt=mutual; keydata=
 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
Subject: Active-high chip select with BCM2835 SPI
Message-ID: <876a6779-5187-6313-3dc0-558d6efdee9a@notsyncing.net>
Date:   Sun, 14 Feb 2021 13:33:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:m20vq+iWCfYuflqLSJqLGrdX8nONWGAou/mXnz4Gy90q/VTY4Jp
 bTDmozHf/NcS+a7ieVROVEqM61Div//HGZd5NJqdCDYiJJDJRrQuWgznNbuMbBOP+3mJJUz
 V+5NBZcK1eTg5ptPyQYUbkiSvrC9NVFGJk+4TiSf1Wxp3na0Yu0s0Ybk+DKYGKEgM4N623U
 fBkpFNnctM+c3FQA5HWRA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:k2eNtY9C1Bc=:zDsdIFgoJjjkwfg6/KPiVb
 ruJhd/GSAndh0KZjptOZ14eoZ9DsBnJmWsCbkb6WjEOjSHgd2/CZ2l+2/QqJo5xcodwYtR4cg
 sAdCjWdePZ2gCap85yE762j8kr6q+PkQMqDhFuD0ZNao7E7+rALWAY1AmQjfQinGPbRbiiE9d
 sKieyEHbWhXQtIRm0Lx/S7dUIct+xkQ7t5b4MRMPDhglMfkdWVsuLm95WpucqWFpk4VgLaifV
 pRDHOZYzhNh+EJit0trXVAAwPSZG1XCRPx8J7axyNUSQA1zO8nT1ijbYnJCFDVyzRBlbZUuPY
 Tywwi0z6qnEP+ihgiw4Ohs5rlnlbZkZ6gBGRTsT8VFntLMPaH6IMExLTG3l2ppkgZFBGeggoW
 lZ0mneSZb/GZQv3q4h7q/vr1up0LozqC7KddkbCUbFOEgXWoE8VtN+1erg9XSyB3RbHydPH4M
 /jWB1Kl3jBOtPv7eeXi3lQMZ3a0deHs=
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

I noticed that setting `spi-cs-high` in the DT, or setting the `SPI_CS_HIGH` mode flag when using spidev on my Raspberry Pi does not have any effect. It always uses an active-low chip select. However, spidev's `ioctl(fd, SPI_IOC_RD_MODE, &mode)` always reports the CS as high-active (even if I don't configure it to high).

After looking through the source code for a bit, I think that this behavior applies to all GPIO-based CS implementations. So I have a few questions about this:

1. Is this behavior expected?
	I think (haven't tried yet) the only way to actually configure the CS polarity is by reconfiguring the GPIO entry in the DT that defines the chip select polarity to be GPIO_ACTIVE_HIGH or GPIO_ACTIVE_LOW.

2. Would it be a good idea to implement a feature that changes the GPIO polarity depending on the `SPI_CS_HIGH` bit?
	Where would be the right place? (`spi_setup` in spi.c maybe?)

If this is indeed a problem, I'll look into preparing a patch. But I have a feeling this is expected behavior and I'm just overlooking something...

Thanks!
Markus
