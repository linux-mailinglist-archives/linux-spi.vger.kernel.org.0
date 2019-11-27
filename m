Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C81110B020
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 14:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfK0NZG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 08:25:06 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:41454 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfK0NZG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Nov 2019 08:25:06 -0500
Received: by mail-ua1-f65.google.com with SMTP id f7so1463133uaa.8
        for <linux-spi@vger.kernel.org>; Wed, 27 Nov 2019 05:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RDzPl7qwmN3CB/sbZhbQgE3EmM4PidJqCgvr5xEm24Q=;
        b=VzL7G+f7SYW/Kg0PQDpGKw0pNcS8skyn8vr3MVxcd+AI5ZjQk1MET7y2Vn8oBdNZZC
         CNJ40D9AdetRQF1Pr38GbL4hjLMibgDQSClqqDkMfRy8MPRKo0I+K9mCfLTSQdscfjX2
         GEswmjo5fvoF44y1vjaDSUGfGrfa9Er4tRneV00n/ghfb/Lgv4ddKbCdmB14QTVOmBjN
         D7KJzRCBE4lUeIVtyB5wSJKx/DDRbVeH44RuT5u0gpmMvs6c0GazKmIMXDRH5hQHSJD+
         sJcjScl9MZ9Hj4Eu+StyRfxFf3aYOtOloOsE5CUHRonECtCG1gbeK9ktGzCucfYyY9ol
         PwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDzPl7qwmN3CB/sbZhbQgE3EmM4PidJqCgvr5xEm24Q=;
        b=sNYPpGiTCHX/9RrdySltuLkH2fEhKq3zHerJPO1j1jwYVdrsxXczGLiqv2PeXxcBep
         U9TIGSdobEbnYTWJIhNOXevI16q17Fsrt2v3J1YjrtvplDgbLTkIoa9zhnbEp3So1OdQ
         JRZQ5cdUMDLcTUFJIhROaocD44wyhIAPbhaHB78ygiSAKUOPK9TL8mEbiD/fBG4XnLhT
         SFd8govY6eeQ8AAZfUZE0hxf7vL5OK8Dy+0fLemNMA79IlU/cG6RC8W15t467ixj05hn
         js2Hkz8pM9yo4nxqeUVFyeAA6gsZ8MXt+TRBmahu4ku47cvxBu1pQT0/Ybc7Ji8PClRM
         V2kA==
X-Gm-Message-State: APjAAAUSlOaRGAva7+ucAUspzujGTYannkuCW76sZ4tjnChxRcWP9PsH
        criTJnkoVVskb9ryMScNwrEr3kx/1koVQJl3T9AGRQ==
X-Google-Smtp-Source: APXvYqxlezsQou8qq9rEG49X3s0jWn6uPOrI59sUbfQT+tmKEcNku/BU8e9S8M4/4KvyGHPL9I4tsH6UyA+PlnMOtj8=
X-Received: by 2002:ab0:61d7:: with SMTP id m23mr2758593uan.10.1574861104265;
 Wed, 27 Nov 2019 05:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20191127094031.140736-1-linus.walleij@linaro.org>
 <bcfa8e29-7adf-8a14-43e8-8e1d73df33bc@c-s.fr> <4eed765b-57af-87a0-f713-de1e6bee3d4b@c-s.fr>
 <9c202a84-16c9-1293-a6a8-674de674d31d@c-s.fr> <CACRpkdYVwV8F0-pp2S4CcSQnDZ00KBvZx2zuTmsFMPUP4cT+yA@mail.gmail.com>
 <d7bde5a5-fdb6-5b31-7a7a-d4e515962aad@c-s.fr>
In-Reply-To: <d7bde5a5-fdb6-5b31-7a7a-d4e515962aad@c-s.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Nov 2019 14:24:52 +0100
Message-ID: <CACRpkdZxY5JvwYDXUaagTNfsDXGeR6vsRPWWWUmwbncYMi0T9Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: Handle counting of Freescale chipselects
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 27, 2019 at 1:05 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:

> Now that I have added master->use_gpio_descriptors = true; to the fsl
> driver, this patch crashes:

Oh strcpm() doesn't like NULL pointers, OK I toss in a check
for that too, thanks.

Yours,
Linus Walleij
