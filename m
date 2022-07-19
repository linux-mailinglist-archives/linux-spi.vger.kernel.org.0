Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8308579455
	for <lists+linux-spi@lfdr.de>; Tue, 19 Jul 2022 09:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbiGSHf4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Jul 2022 03:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiGSHf0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Jul 2022 03:35:26 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF277BC4
        for <linux-spi@vger.kernel.org>; Tue, 19 Jul 2022 00:35:03 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.155]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mcp3E-1ne5kj0eOI-00ZxIR; Tue, 19 Jul 2022 09:34:47 +0200
Message-ID: <5e0e595d-dd5d-b1d9-ca25-82b6f6a029e5@i2se.com>
Date:   Tue, 19 Jul 2022 09:34:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 05/10] spi: bcm2835: Drop dma_pending flag
Content-Language: en-US
To:     mkl@pengutronix.de
References: <cover.1568187525.git.lukas@wunner.de>
 <062b03b7f86af77a13ce0ec3b22e0bdbfcfba10d.1568187525.git.lukas@wunner.de>
 <20220719065213.dxplydnkxcst4v7e@pengutronix.de>
Cc:     "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        Lukas Wunner <lukas@wunner.de>, linux-spi@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220719065213.dxplydnkxcst4v7e@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Eiln+y6qfUE8X/ZOrQXUd6isL1HbXWzjNv2N4ObmW4va/QW7b3p
 85+e7CtUF5dLyX27PECLePr3RLcIBZ0P1QmmjreKR7zBKk8ZXsffPJ/ltGtRcVW8iPZyNM+
 8efI2noU4GTNMmBIz9RFA5KnGXua7fTHxVMP+9ICwgF56oOtFDM/iM0jdAicYZN9nAl4b6P
 SvT2OFuESPfr69VRFsWMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:smC/l88NmmU=:whKOWJv/SF1xHyDZ0eOlfT
 +F3rK1lM6J7xj4prmrPdM5jv+AHmjbqf5gMQ2HUuyA2rz70/pw1ehRoiyoVjAmBBTSAzQjBYK
 c9sYQCugSOY1T5KfuWQBO8bOIPog21gcTnpZJ+8IVUgvdVv1AhABN53w4RaRx4Jge085XTHOv
 ehMZGNCP+4rc7D3cbvuJGsAFtX6Z5kWalckFXAo1p/owgCzYNI6uIqJezmj//zC5BegiS2GSb
 KfFx6/GHczHYhEkMi1dX40G53YJ/Iwc5e9kNII2MIdjxBIl/jT2lapc6J+AuhhlaOZJoB9IOD
 36l2ivqB8oh7iWy8aOUABRcyWHEB3Bisrpp241LM55pacTffdKu00Zr17yghYT1vb/4D0uWvi
 6hmUPLnbvnnADtvLL69YTfrXI57KhqlHrWv0RMbGC9kSTT+2fXy4w7BGen5UbzNVSPGJe4JEL
 Wm2kookWMqYYb9UXXl8A2s1yF6GEWmkK8lMuhctJSV539U+K8RVAPHVuvMpY/9DzpEJiYkivB
 coG0L7TaBxx8pmh4WE/xm9/jiXje86O7peOulodO+GZHBD589/8IJ3nF/dOiE6p9HkH61oFrc
 qk0d0w5inoTcyfkLlmaxugcyK42AwpAscaFiV+tR9c9yZkYZDKHNQnvZt0HdiaqqmOh9KVVPY
 HPICb1H88UuSTvpzDcKO3L7lvFIJTgtkArTdyoHavvcRBL737P2G8I3bCk8okfnKhWOb5zCNJ
 9XMcmoAtTSfUI5u3s7O5IZ34OwO6u9WckHTMi77ITuBFZGuLpQxhwmDfaZg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Marc,

Am 19.07.22 um 08:52 schrieb Marc Kleine-Budde:
> The question is: Why runs the IRQ based transfer into a timeout? The
> kernel that produces the crash has ecfbd3cf3b8b ("spi: bcm2835: Enable
> shared interrupt support") applied (which was reverted on mainline in a
> later patch).

thank for your report. Unfortunately i don't have an answer to your 
question, but maybe this is related:

https://github.com/raspberrypi/linux/commit/c643a3603dcbe6d0feada33915cef1ef896b865e

> I'll create a patch to fix the NULL pointer deref. As a interrupt based
> transfer might run into a timeout for other reasons, too. So better
> avoid a kernel crash in that case.
Yes, please
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
>
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
