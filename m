Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C3A210BFB
	for <lists+linux-spi@lfdr.de>; Wed,  1 Jul 2020 15:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbgGANSm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Jul 2020 09:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgGANSm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Jul 2020 09:18:42 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2059EC03E979;
        Wed,  1 Jul 2020 06:18:42 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o38so18336054qtf.6;
        Wed, 01 Jul 2020 06:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tZ8a6oz3Y8ehLX8HUkQPKYGgSTWKJsg21sJcH2+8iVw=;
        b=hX9RjxXibdgpDLuFtboDrQBKbCbjStq9qgvo5Z2a370FXrP2/9ZDD3+/CebWq4YBe8
         RKGDu62MorQx4rBwcA1k/jBM7CjohwZouzB0vMTnTIh0KFfAMky0pFdA+NemHXcJjLLA
         ai3Jhk4qOU0iev9XIAM3Wcl7I3WSAI5W4Ss7KFvahWZKjzjLEsICMbWR1fuVYqrYkfnL
         JrsR9Cd9lZIRMqMfkHapIlq/8UWZlipAYBBU9awZXGUIyc+HdFUGRZCepjhN5Z1ER8hM
         NNZqP1OmnxZXtL9nRtkIKfPcm1z9jjv97zuJos2HqZxq2teFsxfqu6LC12rRbinJJcTL
         0kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tZ8a6oz3Y8ehLX8HUkQPKYGgSTWKJsg21sJcH2+8iVw=;
        b=Pmz7yF1z9BfngI3GURlU7o/BYqqqoPPQoAhPQQWsVYGe2W5h4I5mgozAsNJrVq2uhU
         k1Rw0SgBVMkKirwBMGiW1DHiRU91vrTK/9h9bqWBaHGpnM6SWHptaHVIPI3c/sEb+G8v
         GgQVJvbDlo3hWY7rFckjc92/VAdFoY9phn8TzJy2emd2Em/AC1rp17dcKR21G0FM4itY
         c2N8jqldcLbxtHarMQE2BwUjzuYiQ4pVn0UaVEdlEW9CVddx/e51j2UiMRmcYEtuL499
         IYjpFQpQ4C7Wnu7KIMNGVFl67aCmY6Dw5y9oiJ2C4CIwJe/aEZx1evgLXlu1TGJR4rrJ
         y58A==
X-Gm-Message-State: AOAM531rneoIeJWvB3QEfZI82R/BoS7ivOBQg+yKZZOgCau2ONPFNv4x
        mRk59eo55bXMbxxGwboOY45+yCFrdHYRaJyY4vEwSNRe
X-Google-Smtp-Source: ABdhPJwcMnkZ4bW0MvgzyrdftwNiSaXI0YU/XF8lrgj8e7pSLPgt1BntWi9/HLZGeZVYmKytlB30FPrRknZRGOGBIaY=
X-Received: by 2002:ac8:6f73:: with SMTP id u19mr26131625qtv.36.1593609521078;
 Wed, 01 Jul 2020 06:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200629174421.25784-1-yamane07ynct@gmail.com> <20200630111137.GI5272@sirena.org.uk>
In-Reply-To: <20200630111137.GI5272@sirena.org.uk>
From:   Daisuke Yamane <yamane07ynct@gmail.com>
Date:   Wed, 1 Jul 2020 22:18:04 +0900
Message-ID: <CAHZ3=rpqq5ZJQUGR54vStbqohcrS_w2beVi4m1S+v=ZWEzVtKg@mail.gmail.com>
Subject: Re: [PATCH] spi: a3700: fix hang caused by a3700_spi_transfer_one_fifo()
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

2020=E5=B9=B46=E6=9C=8830=E6=97=A5(=E7=81=AB) 20:11 Mark Brown <broonie@ker=
nel.org>:
>
> On Tue, Jun 30, 2020 at 02:44:21AM +0900, Daisuke Yamane wrote:
> > transfer_one() must call spi_finalize_current_transfer() before
> > returning to inform current transfer has finished. Otherwise spi driver
> > doesn't issue next transfer, and hang.
>
> To be clear it can also return a positive value and then finalize later,
> there's no need to finalize before returning (otherwise finalizing would
> be a bit redundant) and if the driver doesn't return a positive value
> there should be no need to finalize at all.
>
> > However a3700_spi_transfer_one_fifo() doesn't call it if waiting for
> > "wfifo empty" or "xfer ready" has timed out.
> > Thus, this patch corrects error handling of them.
>
> The core shouldn't be waiting at all if the driver returned an error, we
> only wait if the return value was positive.  Looking at the code it's
> not clear to me how we manage to end up waiting - it looks like the
> driver passes back the error correctly and the core looks like it does
> the right thing.  Have you seen hangs in operation?
Yes, and I could avoid hanging by this patch. But I also understand that
your point is correct. Probably I'm misunderstanding the cause of the hang.
I will investigate a little more.
