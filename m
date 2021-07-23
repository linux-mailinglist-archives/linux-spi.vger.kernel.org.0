Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AB83D3B5D
	for <lists+linux-spi@lfdr.de>; Fri, 23 Jul 2021 15:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhGWNFx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Jul 2021 09:05:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:56807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235243AbhGWNFw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Jul 2021 09:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627047967;
        bh=uOVWPoV+0COS1ebm/CTCvdHxMf0SfnJuHXMIargNVL0=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=aPHbf+xJ1KxStTo6yeuHU9FIsQmVYlMygx9eTy/lWxaQz/dkRb+csx2vne5uMe4oY
         wIqh9pqb5+UUcx3wbbBuCrdmTXRektn+m9wG9wmUgMkFXznhNuRMiFLIpLgFgFJ0ye
         3LvfQxSoWagdr+dimu5theYh7SfG1HUFJ5ZlD1Gc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([157.180.225.23]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIMfW-1lusod2JfA-00EK3z; Fri, 23
 Jul 2021 15:46:07 +0200
Date:   Fri, 23 Jul 2021 15:46:02 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <162608669457.4543.2374973099687363958.b4-ty@kernel.org>
References: <20210706121609.680534-1-linux@fw-web.de> <162608669457.4543.2374973099687363958.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] spi: mediatek: fix fifo rx mode
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Frank Wunderlich <linux@fw-web.de>
CC:     linux-arm-kernel@lists.infradead.org,
        Leilk Liu <leilk.liu@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Hess <peter.hess@ph-home.de>, linux-spi@vger.kernel.org
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <363C87CD-F0C6-4A46-877C-86E07D14787D@public-files.de>
X-Provags-ID: V03:K1:dZfvZWxqxCmhDGOcOppaRh1/0B9ez7nDj/olxCAjAF0eeXmOZfS
 ZRu5+cbCocF31onn+8vNjXxIZ9zb/IiTtjtxpvxrkR8lpdo+az1kVokB0SHlid8ear3IFd4
 ri7OgVx8sAWkCogEgnd7HlG83y90URWfz87/PSeGwYF2Za1If/4WpBzKvYtEWL3wFX6VMUf
 ckChCP3vcqP5kCP2mnyDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:stqKK/Xd/L0=:piszGl6K2a+xGIZxVsOsYi
 RHbRVNglDVIYZQZJd7R96OCkI4JgKkJxmXUNrK5LXvwrHRTyo4VoHTEEL34HxYj6hLRjnGIRq
 PkF9t8U6ngAKSKSxcbrnYoNJtbimGxmJkrRccHC9oDXD3zKY3YeSanLVhXDGIpt+poCxasYxI
 2IbDGejnp8UHK01fle62S8eXHtvZAhZ5dEm76hegTM5D8lUMIrvvZkD8jGEGXwxJdx0X387NV
 //6NAJBLHAAsZ+eV3NyJyAhwth24ORZGyHJWaY2ft1itZLEi8z1do3NzoV3foQ5+ENrpjVbFr
 NtnrVikK70h1WBQZoqwrGekYz89zKdcDK9+NrMwcQqlIxcVxyD3lUTsIZ57bvD0HxoyCHPFyQ
 V4ftcZjY+yhXgr8G9jC3k8CVBpny2iExVQXX3NdWECEMVsTjtPPvKiNeHP/R6OlDxx655rY1h
 Yc+/uMnhUwu2NG4WyQ7OHT/Dj1Ab9FlH3zIbrTz1cGaaMbKv63uSw9TVRXwopVFrjleZUp2Ub
 NX6hXv3R0Xfj9lQf79osB2PpvOIjUqLj9TttPNs+9sJMJsJE2WR0jX5mhgq3Ha39uAC6L8YZ/
 QqcH2SQhyGbb0rs/QE5WMIXlWyOnV8lhfzPaCSJCc16992GJ8bi7SLePRetMQZZDdLkLj/jfE
 IT4LwmmSogSErnBJn2k6IZO8FfTrYuSavaCyEBRZv4fVO1/QODgQeiPyVE3z+a2eCdz7FkJfm
 fvj9Ym+P6Q4P7VOg+8dgSYGWQbpclCsm9DUAv5ctPDNwhGsA+wmTzUor/nwHVWtKVjUDFMOH0
 IKepA0N4StjHUhXB3CGrqtD0KGhdidjFFM/qKhTvEbuLEMIU3b+4RpMyQTIArSB6mDUOm/XtS
 511X5e3kAYE8JA11M3hbe6EX4H7tQj1iaz//6ZKrJw4iYx/nGNF2QSEqdrSWZ2i7f5sU+ULG9
 EypiNUkOnheFshvAsdrUp64PEjVsdpfx1Iupn1jEbBqEz3CBXnxw42uAB7DBnjCDb4VH0g7pt
 zoWu4BZmkCTmuQ6by6WInWgXjSi+otMbayhbj7fp5dTO1CGzUZWboYNaENQub0rMl5rcNf4Zk
 T0DeQ8Yx9rWzMYNqw/rZisY+tjYPXmftXZ2bgRMNyrM6ewRvGX2tKCnxg==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi

Can we add stable-tag i've missed to fix older kernel versions or inform g=
reg to add patch to at least 5=2E4/5=2E10?

Regards Frank
