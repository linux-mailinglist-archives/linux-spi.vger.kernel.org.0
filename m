Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBE22F1A98
	for <lists+linux-spi@lfdr.de>; Mon, 11 Jan 2021 17:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbhAKQLP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Jan 2021 11:11:15 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60739 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730167AbhAKQLO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Jan 2021 11:11:14 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 554D15C01D9;
        Mon, 11 Jan 2021 11:10:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 11 Jan 2021 11:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=RlC15aeJIXWYzAjGk3nDpNnihQk
        P/oJsBZcliF8B0sM=; b=hWTbPAaa1tTdz73fuuZC2bFKRqb0iSDBOJVQQnbFTBh
        ngCrCcDjT9XycCunxx67NVwSCNKCCaxP0eIYVxjv9c3xIqlz/z2Z8EmHDrhUYhBW
        8B32RNI0epkyDSxInns2e3/pn3cA5EkjCht1YhPm2lY54XziBZ7X5okSGv6unsWY
        Be2BY3+XtvNwpP9IOt9Gw48lT8yBi9lgvgfVPFgh/BAV1vc+lLI98pwkdzr7y3Ve
        aU9IBoNGF2JNbeccRYOQak/uaofngrKMY0ilDB2I5XyyHeieaf/OQA06OrMklTv+
        Y7jlyolMQ8e7v+xpdBE4eF97hWYOSBFqBehcz3Vh/OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=RlC15a
        eJIXWYzAjGk3nDpNnihQkP/oJsBZcliF8B0sM=; b=nuBROngLEFLJolmx7TAtFm
        j81oJNs1/f0Bb6+B5qBEZvHElZfuw/n5ho25DyI0RZjEr/9DL4k1lUC4i/vaQOM+
        axK6hNc/Zzs8Y8gEr2+POj2sIDZ03mPI+cEOvKU0QQnEB45GVOHvF49dn2ivYakG
        O7GISFqkCK1UsoExjKYbYsjzHyia0/3gs3XZXUp3dnO9VKSpj48Dq/Z7VeOUEhW3
        6vqdAsRBE9ARLmqSbC3C6bYJum+2bc/B94Vn1JKPMdXrV+ioGscpJpEjsvE7n76l
        3nCvHGg6IkYLgxH5F+33yhHUQ9cOyY8t4cCgIPDwJEuU9lhkdnTwrbSbCzdICmkw
        ==
X-ME-Sender: <xms:X3j8X6aeQZ0CCV4BZPENluYBeDjG-i7L7QtrXA03ej5WilMANfbO9Q>
    <xme:X3j8X9bMd2ZDFZ_Q9JohRfS4MzYoeJyENYOhqm_ruW1SuLglPQRvhNqqjmfIFAvqG
    PSYGnhirIHXkuDsCMk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehuddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:X3j8X0_TsqMmswrusgi3yG1jFxekq4fBLenLHmsBQi0tZBN67YvtHw>
    <xmx:X3j8X8petPDhYGZVji_vCH967mQQQKcCPKp_txQW_932HAEYJAnHug>
    <xmx:X3j8X1qccVR6-S1q2MMO1pCeYuqL-ZQJR8Q1yzYyYcfGKpaWaDN_WQ>
    <xmx:YHj8X80ajq57vQzPCgYYdXXGyn6WtIx26s2MQ3liDyK1PUJgdPGCJQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 901AE240066;
        Mon, 11 Jan 2021 11:10:06 -0500 (EST)
Date:   Mon, 11 Jan 2021 17:10:04 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ralf Schlatterbeck <rsc@runtux.com>
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Fix SPI Chipselect/Clock bug for sun6i
Message-ID: <20210111161004.a6suk2vreuslyj4m@gilmour>
References: <20201226095845.c65lhsmluddvwxsl@runtux.com>
 <20210108085855.p255fioaax4zin4q@gilmour>
 <20210108091815.h35ane6xe6bzhje2@runtux.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hcyownk6ynbn2bgu"
Content-Disposition: inline
In-Reply-To: <20210108091815.h35ane6xe6bzhje2@runtux.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--hcyownk6ynbn2bgu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2021 at 10:18:15AM +0100, Ralf Schlatterbeck wrote:
> On Fri, Jan 08, 2021 at 09:58:55AM +0100, Maxime Ripard wrote:
> >=20
> > Unfortunately, without the author's Signed-off-by (and yours), we can't
> > merge that patch.
>=20
> Thanks for the Reply. I've researched more and found out who the
> probable Author of the patch is. I've tried to contact him via Email,
> I'll follow up with correct signed-off etc when I've got permission.

Great, thanks!
Maxime

--hcyownk6ynbn2bgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX/x4XAAKCRDj7w1vZxhR
xSFGAP4+pvGUN6FvXB9P4ruoXrOKdALuWMBQXrpqrQHzaepxWAEAxXBWZ9bZAIZJ
a/FHIKPIhwGMMWhljimMjvMg5bXzwQw=
=PURT
-----END PGP SIGNATURE-----

--hcyownk6ynbn2bgu--
