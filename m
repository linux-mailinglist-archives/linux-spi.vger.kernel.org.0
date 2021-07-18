Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D70D3CC960
	for <lists+linux-spi@lfdr.de>; Sun, 18 Jul 2021 15:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbhGRNoA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Jul 2021 09:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbhGRNoA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Jul 2021 09:44:00 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E41C061762
        for <linux-spi@vger.kernel.org>; Sun, 18 Jul 2021 06:41:02 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id d17so1534335ljq.12
        for <linux-spi@vger.kernel.org>; Sun, 18 Jul 2021 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OSD+ubn4urjcKC3A+mOlRpEXYnkHBpCPeW5HCq6aML0=;
        b=ioMEUVEEIn2aDdSo+Q4YBlBQNX+x4BxJrBP4SwLWXjjRrqcwVr7kz7ZygrMzk8kziX
         j3Riua8iFnm+OtENdm8lIIl8/tMytVU72gMl+6OuGWCC8VCmLMFl4bysH980rktYd4x3
         ux/K1hyHMJ5vHxoGZI93QbK2m2CHVOydIwoJZAJx3cczeNOL6LtdiP47ek0PycPg43qY
         1UUVDTYKdzDdpq27o3ieCN/odbtmaeLn20jZYAsqsUkcKR2fiACmrjIg5LloN0Pyvo8W
         gVh1mfgu1fEsCFQSRySNQVxwBuvlgjBOp2i5aAwlLRGIqsCD8lQXzPhmaaUUZyhEhGnP
         zBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OSD+ubn4urjcKC3A+mOlRpEXYnkHBpCPeW5HCq6aML0=;
        b=T1tpbN8QxXkMl6vw5bimS7dISAVgyaNxQrA4WuUwBBSvZ7izPjx8hAQDyezxR8rrP6
         730id0L8EOOQRMRUhZIvWtJzgKU9XTX5xGzVhwlMWsGyULG3ZCkl7hbRTxzRskHKKnwR
         Nz17zhZKxbnho33ncDKEXQQ9CyeKOqObtBh7wCXrPMfbcBeGm7q7GCR8cP40tf/GIogk
         oMgHfg06xzGzucQJmTW70Ds3tYB81f4an3G6JPRXpzaDkgF914f+Oh5DMfHskejrEPpD
         TyyoMcoWvAerOW3W3oI3Hq17yT7LcctU+H6E5CpcIy01Bc95le6/B7eP8GBLfpuhZT+y
         x3Dg==
X-Gm-Message-State: AOAM533wbM8DEGUPSalwWWKQp7f+jlGyE09QV8Vsy+lTs626xNCleGo8
        m/+HlGDBnADnS5YqsVJ7/qtMNAJwpjzHCOYQNaU=
X-Google-Smtp-Source: ABdhPJw4X4EJLARn4NmPgqWzOJctMntqy2kmGeFHuMolOf5O1G/u54N0yV/++KC4XP8sOSb/7XIKSSUW3GCDcVRxvgk=
X-Received: by 2002:a2e:a164:: with SMTP id u4mr17959995ljl.121.1626615660501;
 Sun, 18 Jul 2021 06:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210716173927.2050620-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210716173927.2050620-1-u.kleine-koenig@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 18 Jul 2021 10:40:49 -0300
Message-ID: <CAOMZO5A_cXAZafm5VELmFxpX+SQj8kDYuJyrawrqwnmSzMYN+A@mail.gmail.com>
Subject: Re: [PATCH] spi: imx: Simplify logic in spi_imx_push()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Uwe,

On Fri, Jul 16, 2021 at 2:39 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> For each usage of fifo_words it is clear if ->dynamic_burst is true or
> not. This can be used to simplify the function a bit.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
