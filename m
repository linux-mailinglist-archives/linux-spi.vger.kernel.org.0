Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B359E1955F
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2019 00:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfEIWqp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 May 2019 18:46:45 -0400
Received: from anholt.net ([50.246.234.109]:39328 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfEIWqp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 May 2019 18:46:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 19B0310A34BF;
        Thu,  9 May 2019 15:46:45 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 3A3h2IW_Ahbv; Thu,  9 May 2019 15:46:44 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 3618210A34BD;
        Thu,  9 May 2019 15:46:44 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id CAC822FE3AA9; Thu,  9 May 2019 15:46:43 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     stefan.wahren@i2se.com, wahrenst@gmx.net,
        bcm-kernel-feedback-list@Broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "open list\:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: Allow selecting BCM2835 SPI controllers on ARCH_BRCMSTB
In-Reply-To: <20190509203600.6867-1-f.fainelli@gmail.com>
References: <20190509203600.6867-1-f.fainelli@gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/26.1 (x86_64-pc-linux-gnu)
Date:   Thu, 09 May 2019 15:46:43 -0700
Message-ID: <8736lns0to.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=-=-=
Content-Type: text/plain

Florian Fainelli <f.fainelli@gmail.com> writes:

> ARCH_BRCMSTB platforms have the BCM2835 SPI controllers (normal and
> auxiliary), allow selecting the two drivers on such platforms.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlzUrdMACgkQtdYpNtH8
nuhySA/+N/RO3Z8Yoc+fKHRBsufh8kvxUe7tTv6WBVdDwEN6bRS6KVjUflP2j7fE
CuwNjCCJJNzFudG7ufzYGy4p6AVr1YK89a7V1eIlAmujkIzX7dhiXNqg8QxmBheZ
erNrMFofbYI1Vw5/6ULrlb8jsyOEsGcp/OdQbnwpc/0Ww9Bil4tV7e8v8tG4Ig1y
pzMoUnSw8qRpa5lz5yrIBLEDLlAz7TfofZMAa42s1VpGhkDuqgm5ug9UMq23eJkN
cTU0DZhXHAd9m0AU3hyree8tOFoSyP9woPL3Q9VIjgpLN3YOiLtKMoye7yYVCLTl
V80B4VM4YPVFjCH+agq0Y1jtuq2eQ/YlZdTpdiqnsVVRQ+dsSgKec3oz5IQrokbN
a+SuVspTcJUElx//UYqVuJFJLdTwreGnzeWi2U+DuhyzOtS2OQqb+VkKRQXa4vff
Q888zRwVoBm7hVUPkg/Kk8xvAZDH1j6DNLexQ1nHOc/0uKUQw4UHX7GvErUP0kdr
IREH+o/42O98FRKSd033J6ZSwW5K1MfFLZjZighzj2fC6oJ1EEZ3BhOQEmRvlNtJ
myw2ML/IoSg4qcR61ON23pplfALWtOzZi2pwWTNgamaDgdgzIDDXEdVmcPP0V0yU
xppd+BACNw0YMATfRAWIUbIFM7OGA71a4mKJ6cTw7Rl0FUYKei0=
=O1Gq
-----END PGP SIGNATURE-----
--=-=-=--
