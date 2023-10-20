Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BDD7D05D5
	for <lists+linux-spi@lfdr.de>; Fri, 20 Oct 2023 02:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjJTAdA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Oct 2023 20:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbjJTAc7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Oct 2023 20:32:59 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7B6C0
        for <linux-spi@vger.kernel.org>; Thu, 19 Oct 2023 17:32:57 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id 71dfb90a1353d-49d0d90a7ddso105868e0c.0
        for <linux-spi@vger.kernel.org>; Thu, 19 Oct 2023 17:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697761977; x=1698366777; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Yd532uOfUQcIsGH6abp7H3LX34Ezn1ipshE9KOwKv0=;
        b=ZkvtqvqdNn66J9eARWyN09GsrDhmzTK5n0LAdiDR+0aPyV7p0ZKBCP8oRy+G0ZCrK7
         dl+FrSDH/1qffY07ljnFA38oYqZB2aWouYp9gPXX7mbP/i7ME1WvgUl87h5vGueAvcP2
         J2sIsVCGkAhJpDGZb6hJcOHNjsj091WRnYrv9VbTsrA84mZNBQk28qTLyit5rsfVAJLR
         z/fH5kynb5lCrA2xn/fsjdSTApF3oez8khoY68/JD1CqPvgRBddR1UFz83v8kjj9ndZK
         Lse2KwbRCtrjQ/5aSWl2BmBcdXQ/4Dal6uxh2b9cwjZlKgQH8aPeQRKVi2f6GwiQxi+m
         AhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697761977; x=1698366777;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Yd532uOfUQcIsGH6abp7H3LX34Ezn1ipshE9KOwKv0=;
        b=P2cJRqnuWDJR9YrTf6NMnP6ATDQQJW0Pkjcr+Kw+airrXmenRUsiL+l995Rew+ABuc
         npJvXMAAEGKgeQgs/DxETaTPlp7DWoLgiH8vYYMAyZbhIyHFWTj0c4Wzy0f8C1qVYOW6
         dh/VHEa2H23kvx6FODye9/JEXkEeO520lMV7FonScHAGMrz8X5IWABW9msMidkF3Kvnn
         zmLZqPYHn0dUOW5duch+0NBk2NdsyTAK9nqBFf/siu5VhP2Oak65o9qrHB6R1PhTPyj5
         JVncyiK8cSBfzZ8Xsj+SU8/9ULNPLNg0lSkPOS5wXhVEtukLxI9dYEPFybWwvGsSuH2p
         UEWw==
X-Gm-Message-State: AOJu0YzB9eihDptC7TwhWTnQCM/rc41b9TYudjyZcZqguRJ734wm3VB2
        fXOzpg53ivA8U7NL4oJnn+UbTAGiObnFoqbqrmI=
X-Google-Smtp-Source: AGHT+IEJxY1x/vr1imUyfgeRuk80H9v1+J/Qe+5yMwMnD4XWoZbRPBbPm3oH/u+2Q4DjCplwNLiEg+ToCSEYCzC1qPA=
X-Received: by 2002:a05:6122:16a8:b0:499:696c:7810 with SMTP id
 40-20020a05612216a800b00499696c7810mr531699vkl.0.1697761976639; Thu, 19 Oct
 2023 17:32:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:b3f0:0:b0:403:6d85:883a with HTTP; Thu, 19 Oct 2023
 17:32:56 -0700 (PDT)
Reply-To: westerunionbankoffce@gmail.com
From:   Office WU Director <dbofficewutg@gmail.com>
Date:   Thu, 19 Oct 2023 17:32:56 -0700
Message-ID: <CAOOfoFD6gE6TjUTXHk6u5CWebjmDWnFAf-Rf_ubmor2cU2+Q0A@mail.gmail.com>
Subject: W
To:     dbofficewutg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=20
 Irod=C3=A1nk el=C3=A9rhet=C5=91s=C3=A9ge: 2554 Road Of Kpalime Face Pharma=
cy Bet, Gulf Lome Togo

A nyugati szakszervezeti iroda ma arr=C3=B3l t=C3=A1j=C3=A9koztatott, hogy =
korm=C3=A1nyunk
Nemzetk=C3=B6zi Valutaalapja (IMF), aki megtal=C3=A1lta az =C3=96n e-mail c=
=C3=ADm=C3=A9t a
csal=C3=A1s =C3=A1ldozatainak list=C3=A1j=C3=A1n, 850 000,00 doll=C3=A1rt f=
izet =C3=96nnek. Nagyon
sajn=C3=A1ljuk, hogy =C3=A1ldozatokat =C3=ADr be Afrik=C3=A1ban.

Megk=C3=B6t=C3=B6tt=C3=BCk az =C3=96n sz=C3=A1m=C3=A1ra napi 5 000 USD =C3=
=A1tutal=C3=A1st, am=C3=ADg a teljes 850
000 USD =C3=B6sszeget teljesen =C3=A1t nem utaljuk =C3=96nnek. nem tudjuk e=
gyed=C3=BCl az
=C3=96n e-mail c=C3=ADm=C3=A9vel elk=C3=BCldeni a fizet=C3=A9st, ez=C3=A9rt=
 sz=C3=BCks=C3=A9g=C3=BCnk van az =C3=96n
inform=C3=A1ci=C3=B3ira, hogy hova k=C3=BCldj=C3=BCk az =C3=B6sszeget, pl. =
Az =C3=96n neve, fogad=C3=B3
orsz=C3=A1g, telefonsz=C3=A1m, =C3=BAtlev=C3=A9lm=C3=A1solat vagy szem=C3=
=A9lyi igazolv=C3=A1ny.

Tisztelettel
Tony Albert
bankigazgat=C3=B3
Whatsapp, +22871283931
