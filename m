Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE001313134
	for <lists+linux-spi@lfdr.de>; Mon,  8 Feb 2021 12:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhBHLon (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Feb 2021 06:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbhBHLmR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Feb 2021 06:42:17 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15146C06174A;
        Mon,  8 Feb 2021 03:41:37 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id q85so1677265qke.8;
        Mon, 08 Feb 2021 03:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q3dX/ZZNpyOng2mOa+cJcvgyElRSqqTL9YiiTxNE55c=;
        b=WXHCf9NsPUkrwuXGs2bEwWIJQhK/y6CJPd0r11N9VGQeIveIdRn0noETJAZcxdoKxo
         /k+mKxsLC6TkV/QB3moH/VmWnfyJ6ToWWILVCSi3yPjHt/2f+uTaE6Z0AAplsHh3oJ+Y
         ADqL7qBrRXuyPKTyH753OjwevjSF1lUmbn2edokLbau+lj8FYPG+7X3grVokhdWXoiqz
         HMWkyzprCvZw+yfsEEqO5KOu6tZNOijXaDIc3hNkis36EEpYKfuKIua9+gaBllbRX+ZC
         HQ+OSkK08TIKnn/gcIanLZqhBvBicz4lXgUXcY1zPDNlxGoOYJ3An3Yr1ewkfGy6QTIh
         a5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Q3dX/ZZNpyOng2mOa+cJcvgyElRSqqTL9YiiTxNE55c=;
        b=HCOvpMzh5H1fr8SmfZ1DcMuP4H6kztFKsiih/4TteZ9/7eknPvvdsslW/4IVf7i8/v
         BD4a4iK+0DdyD8u4fwpuLTYDLWchvY5Yi4KXtR3cHthypnnSUgsHl12k1N+lHaEH3kzt
         Y6oAb4peKXAa/6girBQNOLmKkL3YSElQHh/tLQFRx0bNr6Iy56eVoGvrCKdE53xFH+uc
         EYMnQbWHVJUxjoEuOIO9USHo9iH66OcMNR9A5ed1wMV9i1kZUSezx//6Acf/D4afq3Gx
         opEZPP3lfGe9ODe/93xUNRTJEhPgqt5ztAqo9NiCKCxd/E2L1y81QzO5oVUVCshvqIsj
         kMwQ==
X-Gm-Message-State: AOAM5336/o/f9ZLs51+M1uCo731THgm1kael2sO4AbeqDU0tCh7Obzj8
        NG1hcHzMn+/yIxEyy4iSgBE=
X-Google-Smtp-Source: ABdhPJzLXDKHWMa3BaBbUoF7dsrD7IHgwpZjCUDzw2IdOQxwUW9E8d4R1CfNGfl4ODcRq1GZhGbACg==
X-Received: by 2002:a37:b105:: with SMTP id a5mr15709490qkf.83.1612784496331;
        Mon, 08 Feb 2021 03:41:36 -0800 (PST)
Received: from debian ([156.146.37.175])
        by smtp.gmail.com with ESMTPSA id 75sm14596414qta.68.2021.02.08.03.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 03:41:35 -0800 (PST)
Date:   Mon, 8 Feb 2021 17:11:25 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] include: linux: spi: Change provied to provide in the
 file spi.h
Message-ID: <20210208114123.GA21242@debian>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20210208113359.31269-1-unixbhaskar@gmail.com>
 <20210208113832.GC8645@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <20210208113832.GC8645@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 11:38 Mon 08 Feb 2021, Mark Brown wrote:
>On Mon, Feb 08, 2021 at 05:03:59PM +0530, Bhaskar Chowdhury wrote:
>>
>> s/provied/provide/
>
>Provide is a correctly spelt word but it makes no sense in context, I
>guess you mean provided.

spot on!!


--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmAhI2AACgkQsjqdtxFL
KRUGqAf/VYhOgaigrtoWVHWH3Yk8m11xj6BGeNcOiKIjvukGZWRIZ6IAkRypR/zn
OmM001OdkGMxhpUY0H2LCjmB1C9wQIG/p/viGTOGHwjahhQEfOCwUkNWTwfyTH6f
rJ+xpmbZqH99b/LglBSMKXZ7+KC3EM2uisiStQa5kw2ObF+Mw5UwR/4NixK6UKCU
RuJ5s6A/DM6tKYlqseKIlWL1FxLJTGDLTc5FZOPyIg4v/9+BMyr3JJRGQoBqWzRf
Vs/NWSya5enffZNHqaEzB354PEz9Wo4hU57NEh+xb54ik4ioZsN7xxbNlq2Ncmt9
++v7U/MRATd5AfeUBEhbinq5fIiV/g==
=y355
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
