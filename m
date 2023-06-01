Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F33719BD5
	for <lists+linux-spi@lfdr.de>; Thu,  1 Jun 2023 14:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjFAMTK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Jun 2023 08:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjFAMTJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Jun 2023 08:19:09 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193FF9D
        for <linux-spi@vger.kernel.org>; Thu,  1 Jun 2023 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1685621947; x=1717157947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HN7O0TX3aeV5gYNThlIecfXBiSOKxAGzD7LMGtLTjwg=;
  b=iB5z0oPH0nHqFSYDsX+hR1SAFYKQR/J00VEcO3PGIoLEA141IqhzIKVk
   7z+JfGZZLIs0VogS9yTKsct2jQDucWV1ShJsQvPzgyty55y/fHVU/nFxS
   mfcuS5XbHpPkbcRAJojsi3NWliifKhiE4yASqrztDrpyUGzrc8FE+019Q
   Tudppwmn2vQm7IyGcywvJokeQqBX3PCxoUFk6pxoJgzUKBGQKdqsiQ9VM
   hWRak/Lux7kYkliwFoiEUB7vJNbB3ZXKWeRN1oDtDo/jCrBEwqW1M2cI/
   OR53cPwtWMWvZLHjfvDcBapL/qRSMv5KmZgeQnh20yLtQh7CXWdJWII/y
   g==;
X-IronPort-AV: E=Sophos;i="6.00,210,1681164000"; 
   d="scan'208";a="31221690"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 01 Jun 2023 14:19:04 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 01 Jun 2023 14:19:04 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 01 Jun 2023 14:19:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1685621944; x=1717157944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HN7O0TX3aeV5gYNThlIecfXBiSOKxAGzD7LMGtLTjwg=;
  b=B+0iCal/BBQOBrYGRqM1ey4Myyzqi+HB/lrqR0ue9J88U3Qok8mcPezO
   vyF9Nj9/A8TdQwuy2wsMMDIrjngP+aTaMzHgCWA3nT16Rgh9gpIfEq2eA
   +1Xs5lpl695yt4lwRYPE9H81ErZmwLFz7br1aEnLOS3IhHpod8JkcJ+8T
   XQn4ka1lrmeRpo1WRLTMf8NzjquTKglyXA6Kky/IUBHxuj/jaWwUkJNro
   MSZA+qzPN+fPazg+1BR3AFXJ6DCMFy81iUr1aHyH1cDRVSKEjAaMuHind
   Rlvnpqpcl9YRjRFv+O/fkXYzNUipxvaizith2pNcq0a7YHMxgOlslascP
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,210,1681164000"; 
   d="scan'208";a="31221689"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Jun 2023 14:19:04 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id C29DB280087;
        Thu,  1 Jun 2023 14:19:03 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] spi: spi-imx: Use dev_err_probe for failed DMA channel requests
Date:   Thu, 01 Jun 2023 14:19:03 +0200
Message-ID: <8271423.NyiUUSuA9g@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAOMZO5CcD5iDkaempdxnQHx1fAgnXAmMq_0MdEq5wNgOLHcMuw@mail.gmail.com>
References: <20230418083505.466198-1-alexander.stein@ew.tq-group.com> <CAOMZO5CcD5iDkaempdxnQHx1fAgnXAmMq_0MdEq5wNgOLHcMuw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Fabio,

Am Mittwoch, 31. Mai 2023, 15:14:37 CEST schrieb Fabio Estevam:
> Hi Alexander,
>=20
> On Tue, Apr 18, 2023 at 5:35=E2=80=AFAM Alexander Stein
>=20
> <alexander.stein@ew.tq-group.com> wrote:
> > If dma_request_chan() fails, no error is shown nor any information is
> > shown in /sys/kernel/debug/devices_deferred if -EPROBE_DEFER is returne=
d.
> > Use dev_err_probe to fix both problems.
>=20
> Running spi-imx without SDMA is valid and not an error, right?

That might be true, but this is not what this patch is about.

> I am not sure I understood the real motivation for this patch.

If the call to dma_request_chan() for either DMA channel 'rx' and 'tx' retu=
rns=20
=2DEPROBE_DEFER, spi-imx will return that error code as well. So far so goo=
d.
You can check /sys/kernel/debug/devices_deferred to see which devices got=20
deferred and not probed yet.
Without this patch spi-imx will be listed without any additional informatio=
n=20
about cause of the deferral. Finding the cause with no additional informati=
on=20
is cumbersome, it's hidden in dev_dbg().

Using this patch additional information is provided, e.g. "can't get the TX=
=20
DMA channel!". So you know right away spi-imx is not probing because the DM=
A=20
channel is not available.

I hope this shows the motivation for this change.
Best regards,
Alexander

=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/


