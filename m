Return-Path: <linux-spi+bounces-9766-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93846B3B62D
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 10:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0E35E1257
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 08:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6246329B229;
	Fri, 29 Aug 2025 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq9wf3GB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380E6278E7E;
	Fri, 29 Aug 2025 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457121; cv=none; b=iQZEJB7ch1H2sDE2far5dyWcfEChsBjY1L+IyT2S2SgiRb8AulIO68FwPKPBizwbMNFp4iIomSYuEDKvns9O6sEsL/kyE7M/unmikB1SuRaIfOe7XMLDclqDX3Oa2O+QrX4miIHjNPArptn1sL7ErHK43ScQmFp2Om1OyOxq86M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457121; c=relaxed/simple;
	bh=HH043YS79MGHDZ5W2kvlINvKLjbpb9wn9S8CCzbMoLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZ625ko9fSnNAl9PlZZycong1Z4FwZJE3nfK+62BkaeoyMSmoAB0iinkcQQJYnCOFLC0j+XVCo6UIHNWtS/1HuG3l9sVyDcBRxe4QvrPR6IKiTF0igDSPGKltrj15GhXLZnrxrWHB6oFpNI+uL1cSgVSNxLRkxUrhOCv+ftmsHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq9wf3GB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649B9C4CEF0;
	Fri, 29 Aug 2025 08:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756457121;
	bh=HH043YS79MGHDZ5W2kvlINvKLjbpb9wn9S8CCzbMoLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mq9wf3GBYyDDbp4G+llWX/LFoyG19QwYpcZVI5o46eOiRdKesbf1LqmlvWbmz3XzZ
	 JpoB2XnFGMGWiE8NIzLg1mu3WQu8qOrzGg5t+fn2IxTyaR9mLzJYUu8ubpfJflYnK3
	 RqstqD1iFonLpToQ+o/FQWiPk/9hovaWikSZ8u9Y8ksx8dv1c3CCrLam0UDv5J8nCS
	 9ZwcyOF5QciSZVyFHAWy/6v91vK15AwDTklHZzXX/bcN4PjV86Y1o65HoM5bJjgTG9
	 u0+9n0C9QDRPuO/m6anPyc7Lgy1+xYu3nAwx7QqOBcufWo4L2imppo/dARkozQRiQQ
	 7O0GsIHT54Yrw==
Date: Fri, 29 Aug 2025 10:45:17 +0200
From: Mark Brown <broonie@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Subject: Re: [PATCH v5 00/13] spi: airoha: driver fixes & improvements
Message-ID: <aLFondxgBAf5rc_P@finisterre.sirena.org.uk>
References: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
 <20250823160116.3762730-1-mikhail.kshevetskiy@iopsys.eu>
 <11fcd899-390c-40b6-b1a0-7286dc1e01e4@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O8bdw/cIFhQ6kFwD"
Content-Disposition: inline
In-Reply-To: <11fcd899-390c-40b6-b1a0-7286dc1e01e4@iopsys.eu>
X-Cookie: Filmed before a live audience.


--O8bdw/cIFhQ6kFwD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 10:14:16AM +0300, Mikhail Kshevetskiy wrote:
> is there any news?
>=20
> Best regards,
> Mikhail Kshevetskiy
>=20
> On 23.08.2025 19:01, Mikhail Kshevetskiy wrote:

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--O8bdw/cIFhQ6kFwD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmixaJwACgkQJNaLcl1U
h9C/Nwf/YbbOIT/qNeOsnG8zmCoF5GEeHaZpCAlu4I8oQoS+7W5yieNiMNcy9J71
vd7fi/TQMQxw1wJtSMzNOeb91S2aFHZmzYZKaAHViHABZKq1i36okc8JFzCtI0Nn
nkY3f0yIsvJ7KDtsHtD6QL5aS+HZK+LqIUhzC6rj79kn8W+III8sYvz31ER6BZP0
BagmFWAL4JBACZxmTWsNUWWHGpUX1tOCKAcwUgeulPn5Ue1VxB8aOtzCY80kL5E+
7GHijmERLCrIM6ZrQjxDG/fLNQLzvjCPf4Nn2oLIrKMEMZn7aGn5EyqG/oe5X0+a
CyXO5Akj+hlsWcMGwgdZMhsj+6uTSQ==
=yOBS
-----END PGP SIGNATURE-----

--O8bdw/cIFhQ6kFwD--

