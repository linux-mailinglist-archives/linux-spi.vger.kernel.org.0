Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0ECBD6A7E
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2019 21:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbfJNT6w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Oct 2019 15:58:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39916 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbfJNT6w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Oct 2019 15:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g3RRw/yKtnYRVxDPDjF4v6M8SrfAWxoHlnr95tgPxXs=; b=ME+Wvu3sesrlzWd3V3o00Ze45
        bDl19yBTurheyQvlM+JgH09dozvSK43jx2xcdglEO5gSKgvYPxyHp7ANIwxLg8RhLRBD5tnkmK4O/
        jSRLPUZYkv8KpaP192Ew/MfdjdEQpeIC5PhVWmbeKTbmhT4SePh03B22haUOZxLaco0cc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iK6UP-0000Gx-VK; Mon, 14 Oct 2019 19:58:46 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 072892741EF2; Mon, 14 Oct 2019 20:58:44 +0100 (BST)
Date:   Mon, 14 Oct 2019 20:58:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        "hange-folder>?" <toggle-mailboxes@bogus>
Subject: Re: [PATCH] dt-bindings: spi: sh-msiof: Convert bindings to
 json-schema
Message-ID: <20191014195844.GE4826@sirena.co.uk>
References: <20190926102533.17829-1-horms+renesas@verge.net.au>
 <20191014195451.GA22084@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GLp9dJVi+aaipsRk"
Content-Disposition: inline
In-Reply-To: <20191014195451.GA22084@bogus>
X-Cookie: Androphobia:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 14, 2019 at 02:54:51PM -0500, Rob Herring wrote:
> On Thu, 26 Sep 2019 12:25:33 +0200, Simon Horman wrote:
> > Convert Renesas HSPI bindings documentation to json-schema.
> > Also name bindings documentation file according to the compat string
> > being documented.

> Applied, thanks.

I've been sitting on this (and another ASoC conversion) waiting for you
to review them - in particular with this one I've got another patch
queued up which depends on it so it'd be good to apply it to my tree.

--GLp9dJVi+aaipsRk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2k03QACgkQJNaLcl1U
h9AhSQf+MPj1Uq18yB8rOagb9gJHay04o39fQ11wHnGsU3Xcj7gXPz7wvsNQkavf
2ZdRD2Z71GAX1DUJxW2Rgtd3Fif219z9UeYam53DIlg6+hgNq/J1GAiLkiPGIwGa
fWwCFNpFqiBDy+FY1fVkRSjvob+ne6WfQCh5pLOVtc67/xQRXTwQST0C446FaTgJ
Sc6JeEARI3OTYhSbUMDNBsn80xJAVJT5GJ8rQ9hPzbalymxQmDTPALbfjJL/CUJ/
slWSDzvZZlCy1ELUWosDGJi1IYSIvwHi4kCN8KPt7ktWrp/tqx6rllS5G12TLOCG
/fnQPIFNSNLQr5hJKGwCFyQyv5WLbQ==
=bj4O
-----END PGP SIGNATURE-----

--GLp9dJVi+aaipsRk--
