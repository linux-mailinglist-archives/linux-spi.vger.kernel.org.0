Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF482EC01F
	for <lists+linux-spi@lfdr.de>; Wed,  6 Jan 2021 16:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbhAFPHN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 Jan 2021 10:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAFPHM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 6 Jan 2021 10:07:12 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE172C06134D
        for <linux-spi@vger.kernel.org>; Wed,  6 Jan 2021 07:06:31 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id h16so1303692qvu.8
        for <linux-spi@vger.kernel.org>; Wed, 06 Jan 2021 07:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CORnUFkJoHfcXpauEjDvGex49ME3+U3TKbywCG/BJZA=;
        b=itNlhoOxbF17d+SgbXuX5OZbhULK8H0P5p32SLrLNKUyQc5lRro0JSBCLVRBgkEeb+
         Zp8Zh11ctsHVJNs+CldSBqJslzHAeUkUsDJG1Ra3j2EnNCKG8/wyqeSAdLc9EkHIcGIm
         H4x/9Zb4vmlPEqjE3YjYetFNXZobRYtlUZn15RIhTzYVmaCI0iRxo+BgOzgrX2VH3UHz
         xqG8B5AdEU4GW3+OzoCb4i/4VfiQ6We2Z9jPFeg72wJgwyDiLFL+z2vfFDCzemR7tkr0
         LR9CqKLyyBgE6CQH7Z2ejRg4CG2Eey5Yo1RBjpcv8MnngtN6qENW9nUPLJFCAPkTPLx5
         T3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CORnUFkJoHfcXpauEjDvGex49ME3+U3TKbywCG/BJZA=;
        b=iuaPY/EfiTHBjOlmEt4jHJAmqVQGhF4PnRYkglub6PCnN5j5yf4ogFP6Sk4+PJPhI5
         ZVLDwgxoFA6Rt+WonYCppnFOkzJCLW5LyA0M5Dtl2SM4b1sXdWaf1cTm+zWUfq4qxmv+
         a7J6yE7Kn94OKrSU+bx296v/+A1CQHOZn4qqRYlzgCi5IKA2QSiH4q6S/9+VqMxoxd2q
         QES5xo6o6FDK95/rXgeAvBEyBh/sLfZ7Rzr1YNRN0wGCK57anzTALs2DT47gOPKI8TNu
         yKriwA2jpPPdMPeFI+YU+AtbItgavr+Ins4GgBa4278arXfTJl4/N6wrUp4/9pVcObWT
         VGVQ==
X-Gm-Message-State: AOAM533/OyvSFEtXvSrsou5cZAPDVKbzu50wuRLpxrp0SceCp1tvnG3E
        yzAOlzqz8/iUwPi1fXjR87GTLiVjx7nz3/N9/UBAE4BSXaI48g==
X-Google-Smtp-Source: ABdhPJzO4jf34qqlGAZ0edLVB7mpvwsDCuXDn+VNlWpy0YROqShCm9/twRsg7qNA9SPCOgK3uEkVBammr9epvqXffoc=
X-Received: by 2002:ad4:43ca:: with SMTP id o10mr4169580qvs.25.1609945591204;
 Wed, 06 Jan 2021 07:06:31 -0800 (PST)
MIME-Version: 1.0
References: <CAF78GY3NWQ1jzkauG26nagcMuqR0=u7zcWLh+wDdrJ8G=e7how@mail.gmail.com>
 <20210106130049.GC4752@sirena.org.uk>
In-Reply-To: <20210106130049.GC4752@sirena.org.uk>
From:   Vincent Pelletier <plr.vincent@gmail.com>
Date:   Thu, 7 Jan 2021 00:06:19 +0900
Message-ID: <CAF78GY3=m0kMd3d4tS92tZS57mY5XeRuXtET+BVVvnTwcdtO3g@mail.gmail.com>
Subject: Re: 5.11.0-rc1+: "Division by zero in kernel." when writing to spidev
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jan 6, 2021 at 10:01 PM Mark Brown <broonie@kernel.org> wrote:
> Please check with the latest SPI tree, there were some issues fixed
> there that might be relevant.

I confirm this fixed the division by zero, thanks for the super-fast reply.

FWIW, I am now getting a "normal" error message now:
[  +1.046688] spidev spi0.0: SPI transfer timed out
[  +0.005210] spi_master spi0: failed to transfer one message from queue
[  +0.922799] spidev spi0.0: SPI transfer timed out
[  +0.012172] spi_master spi0: failed to transfer one message from queue
but it is getting late here and I have not investigated why (my overlay
needs tweaking for 5.11 maybe ?).

Regards,
-- 
Vincent Pelletier
