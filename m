Return-Path: <linux-spi+bounces-4250-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8605958592
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 13:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7304D1F254D6
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 11:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C82C15956C;
	Tue, 20 Aug 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBTZoY1x"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3300718E375;
	Tue, 20 Aug 2024 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152835; cv=none; b=kNrKgRwEBUoOiJZ8R0TJYw7OE5k2mzQ9eWMr6yIGh22O5OirjYh49sXPlJ5gLcqFSfjRlZVAy2QK4ISYALA9KzZyL63kuQLPRX/xkJvbv34nVmdH8AMUy23GzRi7WXd5hTEaLo6auW70hc34L2BXkIj5h7dgmFhk0WmtNf5h+Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152835; c=relaxed/simple;
	bh=lHJ6+oDfDRSRF3HdZB+PSLXyMSQohkcnytX/69jL0Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgNNLzIg7pr/r4WnOQhdrgWldJGiDDK6e5D3edtHGRK/1HXXbhvWWPkeiQ2HqU/z7H0ieG5cRqf11ashfh0nhbDI8k/NkfqWBcOrq2tYbAgXpjzyRMQI17plJ6dnSZtKkCxU9eDvdG8EAzfrurj4JgYA4eBd6IxuuiNuyl6lroU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBTZoY1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6970C4AF09;
	Tue, 20 Aug 2024 11:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724152834;
	bh=lHJ6+oDfDRSRF3HdZB+PSLXyMSQohkcnytX/69jL0Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBTZoY1xQKLKD7jcmmkMKA2u2+GDBIV3A/ayuK0q7Xb9PSq/Krd+J+MrCjZsAJMS7
	 dAu2u+fL8d+yL0twNL4wW5Q7fxLUzXkEVRjfk7wfU4Fdej77ZFretGPpfafJ8cUuZl
	 gOUqqcOX/QK/U52CTQ9ipXIZh3tHuqvyiM9hoPSMgPE8/1ksO/rR5biKG+r+LLahng
	 joOgiB8INIBAJOMnJVDZTNSMv4uza61QpmLQqAobvRy1cY8ewoccTc8ulnz6FGP94k
	 7Bvn47s4VPwPDFuaWkBjtDoo+OJ/yxU8SFbOjl/rhFcSXHdVmYsXgGudxx8c23zvts
	 9GS1G1Symi8PA==
Date: Tue, 20 Aug 2024 12:20:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Revert "spi: ppc4xx: handle
 irq_of_parse_and_map() errors"
Message-ID: <f71823fb-4b9a-430a-92cc-0b9df446ce3f@sirena.org.uk>
References: <20240819195029.2388397-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rhZcKsJxdzR4Ma/z"
Content-Disposition: inline
In-Reply-To: <20240819195029.2388397-1-andriy.shevchenko@linux.intel.com>
X-Cookie: You are false data.


--rhZcKsJxdzR4Ma/z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 19, 2024 at 10:50:29PM +0300, Andy Shevchenko wrote:
> This reverts commit f1011ba20b83da3ee70dcb4a6d9d282a718916fa.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--rhZcKsJxdzR4Ma/z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbEe/4ACgkQJNaLcl1U
h9D0GQf9HGeed5R0Aj2k9VcNoS/Retxwv8y/tRt6Z0jueGUj/LnrM9zoCLo6bTfs
iTEyRpNA9uvVvGBBcBqgJqCbUs9vbNlMeJJ9AgMc8it9Wnhaew7PCx2CAayrvEQx
uMisz27zjLRJUOOr7DlKKR8s6XD8YvmM0L2jvk/VxKYojtrWvnCxRmNpz6qS1gYo
PEj3FSli0suQaiyQCD+vZeGyabPNxZ8l9GsiOIM7UZEiuUF49zmPSJ9wcxr6/Gfb
dYSGsFAIgf02cLBzcaBwkoTFcYvyP9XWulN9rMX6gkXu0PaLefT9D7mK1y4gKxOA
iB5RZRQuuIS4ohbGI83EZ2C7TT1EaA==
=EWKb
-----END PGP SIGNATURE-----

--rhZcKsJxdzR4Ma/z--

