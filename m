Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD6A7B0763
	for <lists+linux-spi@lfdr.de>; Wed, 27 Sep 2023 16:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjI0Oyv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Sep 2023 10:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjI0Oyv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Sep 2023 10:54:51 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ABFF4
        for <linux-spi@vger.kernel.org>; Wed, 27 Sep 2023 07:54:50 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F837240013;
        Wed, 27 Sep 2023 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695826488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bU7T7dDQ/dHFd7LrSzq4NNGKbKWAKTZ4mfNpbgF6ZUs=;
        b=bh26dm8STTmIX6aEY3yids5BNROji9NHQGCOkljcLJGC7bWQN0oVyOYBbPx8EDjBWSUOhI
        kZlgWMO10lk3atwHM1kAVX27i0xASK7A1e+nfUzrjb2Xg6uNXXXTu++hyN2wXoU7cwNdy0
        hFIpSIr3igF9xMGLltEJ8R9cP7nRW3LXTxsocJd9Ha+COgsVI+DmGUQFre4pi0hPCf6uuO
        81rLsrDdebLX/bqTcmFAiWGh2863Q5KfTaG3AUzOKMKt4N1HCzB9QKh2kRgmINHh6GLOkE
        yK+sCCVNwpUWbTpGLujlpRxy+fiuTIx5/uIV9fENKj3PD9H0dzqZ5YAOtT8TYw==
Date:   Wed, 27 Sep 2023 16:54:38 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 00/10] drm/i915/spi: spi access for discrete graphics
Message-ID: <20230927165350.470bea0f@xps-13>
In-Reply-To: <ZRQ+LzIoD+J0BzVp@finisterre.sirena.org.uk>
References: <CY5PR11MB63667FBB6AF5B4331419BDAAEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
        <0d60a78b-0305-4cb3-babe-4eefe5001b29@sirena.org.uk>
        <CY5PR11MB63667AB9958A23970B4B0D3EEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
        <20230912152102.0dfe7558@xps-13>
        <ee4a85be-aa87-4c40-916c-0a796688ad6f@sirena.org.uk>
        <CY5PR11MB6366427A8DD52D9B8B54F25DEDF9A@CY5PR11MB6366.namprd11.prod.outlook.com>
        <1b93fffe-5aac-42f3-9bbe-a307758673cf@sirena.org.uk>
        <MN2PR11MB40938110726F81D8CE305FB8E5F9A@MN2PR11MB4093.namprd11.prod.outlook.com>
        <0682443d-5219-4aa2-a932-ee3e04c0760e@sirena.org.uk>
        <CY5PR11MB63661B36FFAE9455504DACD6EDC2A@CY5PR11MB6366.namprd11.prod.outlook.com>
        <ZRQ+LzIoD+J0BzVp@finisterre.sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

broonie@kernel.org wrote on Wed, 27 Sep 2023 16:37:35 +0200:

> On Wed, Sep 27, 2023 at 02:11:47PM +0000, Usyskin, Alexander wrote:
>=20
> > There is a Discreet Graphic device with embedded SPI (controller & flas=
h).
> > The embedded SPI is not visible to OS.
> > There is another HW in the chip that gates access to the controller and
> > exposes registers for:
> > region select; read and write (4 and 8 bytes); erase (4K); error regist=
er;  =20
>=20
> So assuming that's flash region select it sounds like this is a MTD
> controller and the fact that there's SPI isn't really relevant at all
> from a programming model point of view and it should probably be
> described as a MTD controller of some kind.  Does that sound about
> right?

Yeah in this case it seems the best option if the OS only has access to
a very small subset of what the spi controller can do.

Thanks,
Miqu=C3=A8l
