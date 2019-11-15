Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5CAFE11A
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2019 16:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfKOPW0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Nov 2019 10:22:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48674 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfKOPWZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Nov 2019 10:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yvGphVXhC7kan4yS8OPR8FI6+zg0lqmd5nW8y91qGdI=; b=CRII/5pq9X1slHsMZYuJp1M8h
        +9sKk2a7XZyUZWPC0vq/InQhtD4PUo+mF14nMIkX0kYfAntqaE5YPK1R5jW7Ped/2aX6cDYHjyo1m
        bs6tWPoN7XuQF8lwrdvIGodQWANZTEeZYIyJpUq0xNqWZMK1K+LgLzJcXPXp/MwxBCa8Y=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iVdQU-0000bv-LF; Fri, 15 Nov 2019 15:22:22 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 91A9927429D2; Fri, 15 Nov 2019 15:22:21 +0000 (GMT)
Date:   Fri, 15 Nov 2019 15:22:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source
 and interrupts
Message-ID: <20191115152221.GA4210@sirena.co.uk>
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
 <20191112055412.192675-2-dmitry.torokhov@gmail.com>
 <20191112120307.GB5195@sirena.co.uk>
 <20191112190328.GA199853@dtor-ws>
 <20191112191547.GK5195@sirena.co.uk>
 <20191112193653.GB13374@dtor-ws>
 <20191114222652.GA7517@bogus>
 <CAKdAkRQBrKOUTW8puakA26ODYW9=0H4VhwFhGQAqMs-cMmj3CQ@mail.gmail.com>
 <CAL_JsqKUXPTC-fmUowpaHQpuKTfgfQ6D2n7kOZgkYt+MS7OfaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKUXPTC-fmUowpaHQpuKTfgfQ6D2n7kOZgkYt+MS7OfaA@mail.gmail.com>
X-Cookie: Tell me what to think!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 15, 2019 at 07:52:22AM -0600, Rob Herring wrote:

> if:
>   properties:
>     interrupt-names:
>       contains:
>         const: wakeup
>   required:
>     - interrupt-names
> then:
>   required:
>     - wakeup-source

That seems to say that if we have a device that has an interrupt called
"wakeup" then it must be a wakeup source.  Is that desirable?  Being
able to wake the system is partly a property of the system as a whole
(the wakeup signal needs to be wired somewhere where it can wake things)
and a device might have a signal that could be used to wake the system,
may even be called "wakeup" by the device but for some reason isn't
wired suitably in a given system.

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3OwqoACgkQJNaLcl1U
h9AJgQf+JcZQhkga1MGvTU7f3pEsnMjZ9MRBtcDpMdDLrz4o3Vo5OUCODs2E6W0h
T6j+P2IInqE4J74dF0jwwkNyOPuDwezdBKKUsZp+ERNYwF3aP4JeMJusN3AiAaCL
h4KrVXnaiIi3eJoqhmDU3pq8soeITSYSaZ/pSeKlsRw5j5g/NBzkP6GfjlkBuV6p
X1NzocN46iXcB1NRLVVkrbtxx3et1bPGWs0ZJBkVMU07GXY6i4znWUHB5SvEG4mJ
6qWYeNJOCXxsiSLMOYByRSub+xb4c5HvgtMiRMK8nH9x6dzZl0s51tWisJim6O2q
8RSmewbDkUOuvz1SQEVvd/lEqpyAvA==
=GLB9
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
