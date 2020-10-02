Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2D1280D64
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 08:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgJBGSu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 02:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgJBGSu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 2 Oct 2020 02:18:50 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E45206DD;
        Fri,  2 Oct 2020 06:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601619529;
        bh=m5XI/OtoJviRX5j5H8biLvrnJfLzSt/yDgh3YeqKJ8M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MIqK+8lZ6Z+cyr3TtcBe0Ti4SpTsfUBuf0SBQFLYPz0kNgbl4f9Yhp/pjnTnK8C3x
         DaQ4+7S0PgQ2/FwQxMWH8soxwZk2ZtBU6kn/1gmRGH+8hf5Em+bVFszdc4MeUrDT9L
         UtJ7AYf79Na4TW3WUW1YYSbD9zQearTYeGMuc8Ks=
Received: by mail-ej1-f48.google.com with SMTP id q13so335663ejo.9;
        Thu, 01 Oct 2020 23:18:49 -0700 (PDT)
X-Gm-Message-State: AOAM533PToFXOQMfnq01toEFxTp55uCcAwV7GuBL+KJlVNpoqtWcSP+O
        Q6f2aUDw2rZ6b/465efNs1jjDjLyOCb/SYUyX5U=
X-Google-Smtp-Source: ABdhPJyJG8+fduSSWgQX63WCX2hMCN2Y9svLP3ptOTYwOPtXGpYuXWZ0lGiJmIJxw7rOHwEkR20SH6+bFhvP/JvRMXw=
X-Received: by 2002:a17:906:af53:: with SMTP id ly19mr613748ejb.503.1601619528324;
 Thu, 01 Oct 2020 23:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201001161340.GM6715@sirena.org.uk> <CGME20201001182315eucas1p1b1fc9d5d0ea91db6e56e92d5cf2583e5@eucas1p1.samsung.com>
 <dleftjft6xg60r.fsf%l.stelmach@samsung.com> <20201001190257.GA11048@kozik-lap>
 <20201001194339.GX6715@sirena.org.uk>
In-Reply-To: <20201001194339.GX6715@sirena.org.uk>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 2 Oct 2020 08:18:35 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe+w=mYfX9PaG=FXt5mWPqBiqe833mdetCQWca+H_nXSQ@mail.gmail.com>
Message-ID: <CAJKOXPe+w=mYfX9PaG=FXt5mWPqBiqe833mdetCQWca+H_nXSQ@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 0/9] Some fixes for spi-s3c64xx
To:     Mark Brown <broonie@kernel.org>
Cc:     Lukasz Stelmach <l.stelmach@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        linux-spi@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 1 Oct 2020 at 21:44, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Oct 01, 2020 at 09:02:57PM +0200, Krzysztof Kozlowski wrote:
>
> > That is correct. We did not provide final comments on the list so they
> > could be added here - in change log. This would also be an explanation
> > why there is a resend. Another solution would be to extend the commit #7
> > description - why only CMU case is covered.
>
> If there's a new changelog then it's not a resend, the changelog is part
> of the content so I'd expect a version bump for that alone.  IIRC the
> changelog needed some clarification anyway?

Yes, documenting the non-CMU case in changeloge would be good. It
should be also v3 because of another reason: two patches got reordered
to a more meaningful position in patchset, which brought minor
differences in them.

Best regards,
Krzysztof
