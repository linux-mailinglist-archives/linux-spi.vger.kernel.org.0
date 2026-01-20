Return-Path: <linux-spi+bounces-12518-lists+linux-spi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-spi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLMQI5nKb2mgMQAAu9opvQ
	(envelope-from <linux-spi+bounces-12518-lists+linux-spi=lfdr.de@vger.kernel.org>)
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jan 2026 19:34:01 +0100
X-Original-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AD249865
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jan 2026 19:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 779517C9D2F
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jan 2026 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD5433E34D;
	Tue, 20 Jan 2026 16:53:03 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137FF33DEF9;
	Tue, 20 Jan 2026 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927983; cv=none; b=V8IpksQgFqIjS9q2BjJGHBQm6DMzg1GPERMTe1TXP1oEUOdaNdbIKzaukYzUxlbstizBKFIG9W6U7w8urW/h7SwQFVVd0gT65uQGAGC14DXh8d4a2Lymadz2hldf2NtqaJXrvGr4TtLCnaf+Nhv9cUs6raQMu2x/hRu+GrmNVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927983; c=relaxed/simple;
	bh=Ger41I8x6kqqHGn743sCsSsB7ojX5dsspT8FOm5T+W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9NXui7qB1slnefNSWL+w9VmKt57WleVNpRERq0ibyJ9qcWtKP2TDDDtrVL5cuR0r3TVzfL75H/L0rtAbbyhzYo3EKdQanZhGZ31BCNYPUxRxL/O/x7I/XpPpRhpFyXHUmIqo44y718LHR6s+EBxiNTmBnxg95JT0Cqba7A6fJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F8FC16AAE;
	Tue, 20 Jan 2026 16:52:56 +0000 (UTC)
Date: Tue, 20 Jan 2026 16:52:53 +0000
From: Mark Brown <broonie@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: Vishwaroop A <va@nvidia.com>, thierry.reding@gmail.com,
	treding@nvidia.com, jonathanh@nvidia.com, skomatineni@nvidia.com,
	ldewangan@nvidia.com, linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, puranjay@kernel.org, usamaarif642@gmail.com
Subject: Re: [PATCH 0/6] spi: tegra-qspi: Fix race condition causing NULL
 pointer dereference and spurious IRQ
Message-ID: <0cba7a42-f322-48c8-ae89-966779355420@sirena.org.uk>
References: <20260116-tegra_xfer-v1-0-02d96c790619@debian.org>
 <20260120112242.3766700-1-va@nvidia.com>
 <aW-seUXIJv4Lz7bK@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4BCuffH8cCdM3zc9"
Content-Disposition: inline
In-Reply-To: <aW-seUXIJv4Lz7bK@gmail.com>
X-Cookie: Slippery when wet.
X-Spamd-Result: default: False [-1.86 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12518-lists,linux-spi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,vger.kernel.org,meta.com,kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@debian.org,linux-spi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-spi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 26AD249865
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--4BCuffH8cCdM3zc9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 20, 2026 at 08:49:23AM -0800, Breno Leitao wrote:
> On Tue, Jan 20, 2026 at 11:22:42AM +0000, Vishwaroop A wrote:

> -       if (!tqspi->curr_xfer)
> +       if (!tqspi->curr_xfer) {
> +               /* Spurious interrupt - transfer not ready */
> +               if (!(status & QSPI_RDY))
> +                       return IRQ_HANDLED;
> +               /* Real interrupt, already handled by timeout path */
>                 return IRQ_NONE;
> +       }

IRQ_NONE means that there was no interrupt flagged by the hardware, if
there was an interrupt you should return IRQ_HANDLED.  You might confuse
genirq if you flag it spuriously.

--4BCuffH8cCdM3zc9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlvsuQACgkQJNaLcl1U
h9D8FQf+NkYChgWwqjcsZfFdF/vvQsvS8zmlpHHQwO4TKImqgDFA6yN854wf9MZ/
JA45cUZha9G/kqfgK983F5w1WdLGxc15OG0/DzCihsS1D+t/NOwKKObwHwxAhzYa
FfADNvXYEegiprKwRNpFwX1QwK4xB3g1cBhg6tr5yQAYnvScRJtBEajHi1Yi2IxH
4jO+zYzgrSiVlrnEOX7r/GFQ/jkLSXoaqfbvbKgx1lWpjsLP+XwyyfG6OzZIg+P6
AzWIDTlvUifvCi/7tGk+NPWOrAatuj68KGr2hpEV6k1wBnAjt0x6hB+prDFef14J
5dSnyIZlVeRzBaWeb0LxnG8IkZjQjw==
=dVgB
-----END PGP SIGNATURE-----

--4BCuffH8cCdM3zc9--

