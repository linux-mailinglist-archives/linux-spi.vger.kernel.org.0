Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D73292D05
	for <lists+linux-spi@lfdr.de>; Mon, 19 Oct 2020 19:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgJSRnj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Oct 2020 13:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgJSRnj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Oct 2020 13:43:39 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E7BC0613CE;
        Mon, 19 Oct 2020 10:43:39 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c21so1040714ljj.0;
        Mon, 19 Oct 2020 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0vrWp9pDBfjblkGus7WCqC4oVtXZHu9bkKVvgRqfJGA=;
        b=m1F1+vh/eEYSo2a3Ta/q+PMJkFsWw6jIAD9ZPvAyKdlQH7nsz4NtpHU+wAtQ+S5ANh
         hCSC3x0QHVKLT4Ev/fOF72amwXKpf7OxknxMD1gjZ09g7u3Pok2UsChz/pth3zgzE/na
         DXVpTyId1naSsI8T+opQ+7ym+EcHyKWQNBfOClNGZemblk0dx3fmMkxf+m3nffM12W9y
         dy1jnB5cEL9i5C//t/rr9XBOWp8epGqzCdziyrJLRCkzlz4IXNC4mvfzIqcjib/SB9lv
         C9bPCqoPuhW+4cC0K/N03ZbThEMOqvQKZU9QhoTEiUHMhzOQ9iIenL5oSy+em4HoJtgx
         G60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0vrWp9pDBfjblkGus7WCqC4oVtXZHu9bkKVvgRqfJGA=;
        b=Dc/2j4twOiJ0GURMYi9QlnVWrl0osYsGsLaW5TQhPgKavJHn7tnVa9uVsFU5vN3fuj
         jZDYRxd7/+qE+2gIjDNZTWeflQ22WBfDhzsMa1WRv3WdBLioJNeHCkjTEvlOYH7g9IfX
         9MkcRQmxB3CrZ0JutcuySP5zpDtE2DVB84lGG0evETjM8LSs1Q2UX7dKBMjOb2HtfNJf
         CSFyP5g7cou+jcbMCdN2FQ8YFjJTfif/Am+tk5qsTU6vEBauW3TtIOeNG9Er7USTQ7He
         aDv974DSqj2NXEw6PScTMaOtmqwp3F0RHBvDQqnuvGM0h2cavAkHhTQaQARnoAeL5g0K
         MqsA==
X-Gm-Message-State: AOAM533ztA4cCd6koCnymrYBP+C/v+uKksv8+bBLWHJoYdo5fsQND6N8
        8/GiaushdhKnvzSQb6FRv9iCYienCiIZ5A==
X-Google-Smtp-Source: ABdhPJw5tjN+paj+xrwRXiSeXGqzW2Mu5QDoGZjT9BgbnWvfsMNDjjKCtMCS+eUuFs3odSY4cub/Tw==
X-Received: by 2002:a2e:83c9:: with SMTP id s9mr454939ljh.168.1603129417240;
        Mon, 19 Oct 2020 10:43:37 -0700 (PDT)
Received: from [192.168.7.20] (95-25-113-230.broadband.corbina.ru. [95.25.113.230])
        by smtp.gmail.com with ESMTPSA id z10sm76647lfd.159.2020.10.19.10.43.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 10:43:36 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] spi: spi-sun6i: implement DMA-based transfer mode
From:   Alexander Kochetkov <al.kochet@gmail.com>
In-Reply-To: <20201019082129.myxpxla5xwoqwldo@gilmour.lan>
Date:   Mon, 19 Oct 2020 20:43:34 +0300
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4EC91DD5-5611-4B48-B6FC-00690B400584@gmail.com>
References: <20201015154740.20825-1-al.kochet@gmail.com>
 <20201019082129.myxpxla5xwoqwldo@gilmour.lan>
To:     Maxime Ripard <maxime@cerno.tech>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> 19 =D0=BE=D0=BA=D1=82. 2020 =D0=B3., =D0=B2 11:21, Maxime Ripard =
<maxime@cerno.tech> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
>=20
> Hi!
>=20
> On Thu, Oct 15, 2020 at 06:47:40PM +0300, Alexander Kochetkov wrote:
>> DMA-based transfer will be enabled if data length is larger than FIFO =
size
>> (64 bytes for A64). This greatly reduce number of interrupts for
>> transferring data.
>>=20
>> For smaller data size PIO mode will be used. In PIO mode whole buffer =
will
>> be loaded into FIFO.
>>=20
>> If driver failed to request DMA channels then it fallback for PIO =
mode.
>>=20
>> Tested on SOPINE (https://www.pine64.org/sopine/)
>>=20
>> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
>=20
> Thanks for working on this, it's been a bit overdue

Hi, Maxime!

We did custom A64 based computation module for our product.
Do you mean that A64 is obsolete or EOL product?
If so, can you recommend active replacement for A64 from Allwinner same =
price?

Alexander=
