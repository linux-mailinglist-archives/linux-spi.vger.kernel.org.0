Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2982FAA6F
	for <lists+linux-spi@lfdr.de>; Mon, 18 Jan 2021 20:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394018AbhARToc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 Jan 2021 14:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437239AbhARTan (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 Jan 2021 14:30:43 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A1AC061573;
        Mon, 18 Jan 2021 11:30:02 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id b10so19401695ljp.6;
        Mon, 18 Jan 2021 11:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W7LCkFLXHpgyS/l5g2mFghb0Ve1BP8WfDv5v0wdLNGA=;
        b=Mu65cJmmqIYmhPrHrSEIxJSS9qe6QL2yRPqJ2NDyT9X/Z8kLfMfjhvemzNDtl4WUkf
         w0FU4JKAuAWa7xtDU1mGW3Mc66UpnjA1MeWNzz7dht9uFjCD0YP+RlLujY/TdoLm0srD
         XJGXrtylWFfUNZIE5kMADMbqveVD4BtrXq/NHT2jGpvG18fgXPCMjdkvTY53Yj2BiLZc
         wfMnpQC2xaWAhvclS50IuBURoR5fODHQ8sCG1GFMbp9Y7DeuV9h3alMFWtPg1wFut695
         Q4pszFhg2zyQI/1D0YDVVCiGRLHTbFarrU/ai83TozSww/1I43OnFHyirOpwOyyNg4QC
         0aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W7LCkFLXHpgyS/l5g2mFghb0Ve1BP8WfDv5v0wdLNGA=;
        b=Ony5uqsSvX1zZexAaWL+kCAowrejkCOHP+S555S6CVK6uUpAeuwOi/YDwt6U7rcGK1
         0BCsknElECAevoYfergDPY25LK92M7Cv65rix6WlKCy2oVY++aizF0DkLa1lJvgQotPi
         3QoqJ7mAH5mF6kzuI1ttSJGsSETF7kZmkBabSyh4DG4n46H/wI+fgHTqYquwHf2i0p8J
         tI7DUDclnvSc/hGotbJowZ6FlQhOeG92188XqjIyG6cOZH8hJtfbl5xjpBFpNzRX5P7X
         GW04IrRsKp0oRAkuAkdtrG5zbCwxfwQixeeZCGQi9QT0NuevvkXrCeqx1YQlbWCGuB4x
         nJtQ==
X-Gm-Message-State: AOAM533EYjYfeev5JuD9zrLKA6CkLGcj10rm7vmNyjwqCJo7z5lde/TV
        lk0jmcp2xoUUkG6hDsItF0qYYxnZF9TYzfSY+fs=
X-Google-Smtp-Source: ABdhPJxUSYipS/C3yZ3LWu7fcUcfoWcK48wbESthdrHHmmVji58URkG5qrpzvkIY50hg52lAHp+bPDZkcyfIBW5JPrg=
X-Received: by 2002:a2e:b4b3:: with SMTP id q19mr426523ljm.121.1610998201263;
 Mon, 18 Jan 2021 11:30:01 -0800 (PST)
MIME-Version: 1.0
References: <0f51ab42e7c7a3452f2f8652794d81584303ea0d.1610987414.git.agx@sigxcpu.org>
In-Reply-To: <0f51ab42e7c7a3452f2f8652794d81584303ea0d.1610987414.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 18 Jan 2021 16:29:49 -0300
Message-ID: <CAOMZO5AcMKu-pQQ94L9USvz3ujJFdcRFPd2t1-8j8xU7hBHoxg@mail.gmail.com>
Subject: Re: [PATCH] spi: imx: Don't print error on -EPROBEDEFER
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jan 18, 2021 at 1:31 PM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> This avoids
>
> [    0.962538] spi_imx 30820000.spi: bitbang start failed with -517
>
> durig driver probe.
>
> Fixes: 8197f489f4c4 ("spi: imx: Fix failure path leak on GPIO request err=
or correctly")
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
