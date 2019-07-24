Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFA177282A
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2019 08:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfGXGTT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Jul 2019 02:19:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:55597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfGXGTT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 24 Jul 2019 02:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563949135;
        bh=D+gEbfwgaLvlLdhFCwTJMZNO9xaSlTRsrYukU3+uer4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Whr6y/h5H6clav3tw07AJce4YSNDIvPuCitYGga5eg9yEXNUUncLMaFp/eiomkH5f
         iYqJSUe4KDhi/E2/xa2UNjRDqlqJWaMtUnoHu8j8U+pseSDkAkETF8dI8r+2WqXN3l
         tto1y0Oy+NHwP6sKZuGGLnbOLABHenCaO9J/W83o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfSrf-1i4eWq1PjP-00P8iI; Wed, 24
 Jul 2019 08:18:55 +0200
Subject: Re: [PATCH for-5.3] spi: bcm2835: Fix 3-wire mode if DMA is enabled
To:     Lukas Wunner <lukas@wunner.de>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Eric Anholt <eric@anholt.net>, Nuno Sa <nuno.sa@analog.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
References: <328318841455e505370ef8ecad97b646c033dc8a.1562148527.git.lukas@wunner.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <f8d7d3f4-260e-efe2-328e-a88a057cc08a@gmx.net>
Date:   Wed, 24 Jul 2019 08:18:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <328318841455e505370ef8ecad97b646c033dc8a.1562148527.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:+emEDpTUnTjF20Ze+aa8FhLqroErc3BzHUH106315jYfFjc5l6S
 CN2fnPkJQCs8hh789r+o5QMPRdZt8dKCEsv7kIUstedF80iONqz/lcKJ5siGtaHKPVl2I5h
 +wIq63jF2qfRXDdFTfd6kd86/vJwOwFrNDL5XN9W1MoOq/ZLeJs/zI4IYMRwQIgYq7GcSv0
 FFoaudDk0TOnXoPKqd7nw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:01/Xjc8Lw8A=:naeY1klCLRxAkdBEJECsMK
 +tFL2CS786UUnBdSTihIgW6UfpHrS5PLI4zItB9+glOD21hDGzAyX4FaLJKk/qQ9slhjVxLeJ
 jCr2sNbkmKWFVFDucIFXOVMKkzcwAWy1JjHjsu5LHC2V/ynXHe1Ju+EqYSKAztAsANeW16RMZ
 wDmj41SJXmREK5wbRJ/9q0K40PF+QExa5jYDmD6t4361ErA6S9D4InFiuxO9W4/wU28cGhJ6b
 6zmzxHaM+sKB+D/uHmEtz/siFznY9pgij+jNHfQwHNtq/4G1ySsXxtLxwb4Om+Wpay5OvHV0Z
 l5Sc0B/aOKxlmr4jR7KZkooYLu8yi7Z8a/o+BUZd7TyK/MRXKxUMBMdsGDPIuI2WcC5Lasv/C
 m8XgiYeZ8nKnMAThuUZOEJSQq/hzkfGMavzKLaNSFhEb2fFMs3dxtRF5ZHweDevZ3tSrugrM6
 9xk4cZgMKnpaqiZl0QqGKQU30qahdpiPqTfk1yWa7x1z301Q9q9DuhDGhOLi7//+J3hjDgM+P
 ubU34b9/4m630kmaQg04bpfOmvXqbzxvsruCSI02FYDdEhha9CtjN8iXtKIBzTNMXYjtPkiz8
 6kHuVRBJWyxxHkvVB+jawXLQMPSdQQ05w99y4TaQHWMiXDu5eUyDKMYj3y7NG/dpMWWRZAd6y
 YhGPX96dB1RfrJrfLGZPJ2qSBEeV9W4HpXcAE/TeLJ7y01fYmI4rNxNQw/a2WRVAjxiBrerxv
 c2KHOEOe5yAuQYeSuNAHJnJenAQ2FLF7JkX4YTkMHUxH3TyaK4B9SbrIJqnnxCXZxKT2LQ3Cg
 d5ncBoMlshub1v3lC5YLNG7MF5xdR5wQ7O31R/4DQ1Byz7s6nLUU0iYN0HcfsiC+uvQ6446wE
 9xD0+mFDbE4Cz7nTrbRa4q8qjhtFZ1D+YJN25aQvFjMkiGYBVKuKzJlg36C7Cpl0T1Yl0I4Sq
 CbLOoF+zWO12+RCybbkIHqaAwSmRxjWgVXCzNqglj71NVcRAkVk3mBOIZJWcOcoTyvhAXw9L1
 A916Y47HTKK59sM3c2wvQGp+1YzeFd1mUVxYzLXSaolNhNh4xz57w6f5N5aRKXdNKJ0YHSwNE
 19kPLEqY/xfYzE=
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 03.07.19 um 12:29 schrieb Lukas Wunner:
> Commit 6935224da248 ("spi: bcm2835: enable support of 3-wire mode")
> added 3-wire support to the BCM2835 SPI driver by setting the REN bit
> (Read Enable) in the CS register when receiving data.  The REN bit puts
> the transmitter in high-impedance state.  The driver recognizes that
> data is to be received by checking whether the rx_buf of a transfer is
> non-NULL.
>
> Commit 3ecd37edaa2a ("spi: bcm2835: enable dma modes for transfers
> meeting certain conditions") subsequently broke 3-wire support because
> it set the SPI_MASTER_MUST_RX flag which causes spi_map_msg() to replace
> rx_buf with a dummy buffer if it is NULL.  As a result, rx_buf is
> *always* non-NULL if DMA is enabled.
>
> Reinstate 3-wire support by not only checking whether rx_buf is non-NULL=
,
> but also checking that it is not the dummy buffer.
>
> Fixes: 3ecd37edaa2a ("spi: bcm2835: enable dma modes for transfers meeti=
ng certain conditions")
> Reported-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.2+
> Cc: Martin Sperl <kernel@martin.sperl.org>

Acked-by: Stefan Wahren <wahrenst@gmx.net>

Please use my new address in the future

