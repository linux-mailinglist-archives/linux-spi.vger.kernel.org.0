Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586E076094B
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jul 2023 07:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjGYFcK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jul 2023 01:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjGYFcH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jul 2023 01:32:07 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E38E173E;
        Mon, 24 Jul 2023 22:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1690263118; x=1721799118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qQZupKSzv9Uo6GUrQen1E/1/QDNyIeZtBUSCewcZU2o=;
  b=Cc3BJxU34wvNWbH0M9F3isYxO2BmXJzdOFnNG81PFnNe829jTDt9zkNH
   fFb79VdqfAgJ8bc1nPcT20AxwggK/Sj9E1NDtfY+DopkkBZNVwcGSqzVs
   vobfve51amQdC4ZsIMgz14Vqk/dYjtOFXCCGfC25UmYkm25Vgd/bgkT3t
   mLISDy9xhiUFVK0OSAGY6euyVh5lqnyBazn1qP2O52FU3Ln7VJ/6RAZKz
   BirvUfRX5yd19GGZEv9DWiarf3D/0flUF6GzuPr4UCyR+WhY/827cA3sy
   QgV37eHbhDgXFptfeJvzQtThsp9H2nJsMjN+IH1RKDxt+s6FYFzy+QNi4
   w==;
X-IronPort-AV: E=Sophos;i="6.01,229,1684792800"; 
   d="scan'208";a="32092855"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 25 Jul 2023 07:31:56 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 0DB35280075;
        Tue, 25 Jul 2023 07:31:56 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Conor Dooley <conor@kernel.org>,
        Mirela Rabulea <mirela.rabulea@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: media: imx-jpeg: Add clocks property
Date:   Tue, 25 Jul 2023 07:31:55 +0200
Message-ID: <1908243.taCxCBeP46@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230724-unscrew-bonnet-3c86da806df3@spud>
References: <20230724122101.2903318-1-alexander.stein@ew.tq-group.com> <20230724122101.2903318-3-alexander.stein@ew.tq-group.com> <20230724-unscrew-bonnet-3c86da806df3@spud>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am Montag, 24. Juli 2023, 20:26:15 CEST schrieb Conor Dooley:
> On Mon, Jul 24, 2023 at 02:21:00PM +0200, Alexander Stein wrote:
> > i.MX8 and i.MX8X both use two clocks for accessing the periphery.
> > Add clocks and clock-names properties accordingly.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > Changes in v2:
> > * None
> >=20
> >  .../devicetree/bindings/media/nxp,imx8-jpeg.yaml          | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> > b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml index
> > 3d9d1db37040..2533e16720f2 100644
> > --- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> > +++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> >=20
> > @@ -46,6 +46,14 @@ properties:
> >      minItems: 2               # Wrapper and 1 slot
> >      maxItems: 5               # Wrapper and 4 slots
> >=20
> > +  clocks:
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    items:
> > +      - const: per
> > +      - const: ipg
>=20
> What do "per" and "ipg" mean? I assume "per" is peripheral?

Actually I don't know what "ipg" stands for. It's a quite common name on i.=
MX=20
platforms though. I opted for the names currently used in the DT. The drive=
r=20
doesn't care for the names currently.
But cross-checking the reference manual these clocks seems to be called "jp=
eg"=20
and "ips", individually for both jpeg encoder and decoder.
Mirela (added to recipients): As the original author of the DT nodes, could=
=20
you provide additional information regarding the clock names?

Best regards,
Alexander

> > +
> >=20
> >  required:
> >    - compatible
> >    - reg


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


