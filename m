Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4B8311E00
	for <lists+linux-spi@lfdr.de>; Sat,  6 Feb 2021 15:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhBFOwa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 6 Feb 2021 09:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhBFOw3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 6 Feb 2021 09:52:29 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65205C061793
        for <linux-spi@vger.kernel.org>; Sat,  6 Feb 2021 06:52:14 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id q2so9769654eds.11
        for <linux-spi@vger.kernel.org>; Sat, 06 Feb 2021 06:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=GAECis7c8wq8EDbaXoTNet289puBySVQ4wBRTbYfk3EwABGnSCAPiRrga6agfLFgID
         dcKVBcXeLUvpTlrjfHyfZ9CkPbzp2j7dgsJ1xcmTjrlqnFbVLe1wzLN7SQ45CDbI+tcm
         NwhluqS405tyqO3599K/6s0UY3KPXGQggO1hLd2C+bV7Uqfd4awdr5kCqq6fghsHDyBo
         l/2XDaXXrilgmgIWwFsM3MPfmeQ+/m1ErXbLv1l8QMuUbdnG/6oHDZQB9YYEIN9uxcSL
         QO3+BiFb+7zLBCHiUAmKKL27IH5Q/cHmK71XcxYF4tjlkaufI/r6vWPlScX1Kt4m6UKx
         LsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=J+3kRU2Gd4RvGaxMieuACgVVvNFLkemZKKWKlfu/GlxNaByMTG8wG0KZyFP8OTSZ17
         hHvHvK9Ur1QO7znsu4hWdSS8By+bci3kWaO5lEEa8Q9BGSGMWK+ivWPGL+XjMN3OObm7
         OD5PJb70jiIUF0c8b4dZkYQJVAPPQGQ/CnRDeMMDesWe0fxkq4sfENp5aPeo0aG/EFAT
         6zpKxIjQcySjN8J6vSBoQUxeP+L1uYA/CGvG4/V+ujS3yfWLoRp7vJhGBqnwd45Dt9Zx
         AmcljpIKKFOqBvzDUJVOZyVuT9+5ts+0xoD92hqXiit7FV3b5zaeNQ1eoGdhgmrPm6EE
         LzsA==
X-Gm-Message-State: AOAM530U7oEHr+xS8Fvpd+e8tfRatVz68hlO+LGjJRgwLi4JL9c+mVbi
        Lw4XPXm2cE/u5TF90m0h1kZkVVdju8keNLOe6ug=
X-Google-Smtp-Source: ABdhPJwPB673tdPJAnbdAVSSiUB4P38oeTzS0OKD6qiuGsJ2xV3AQEIqYIRsgDTvGuh32gySXCxoQnX+q2PK/ff1EOQ=
X-Received: by 2002:a05:6402:558:: with SMTP id i24mr6550332edx.190.1612623133165;
 Sat, 06 Feb 2021 06:52:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:25d0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:52:12
 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada9@gmail.com>
Date:   Sat, 6 Feb 2021 15:52:12 +0100
Message-ID: <CAGSHw-DwS_3tE5g-x4S=gUAOqbRqBDDBDBXuCv4dqjckhc_aNQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
