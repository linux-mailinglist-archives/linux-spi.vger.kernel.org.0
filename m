Return-Path: <linux-spi+bounces-12474-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7CDD38F50
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 16:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E8023014BD7
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B35D20C477;
	Sat, 17 Jan 2026 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ah4ykgAd"
X-Original-To: linux-spi@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62D5B67E;
	Sat, 17 Jan 2026 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768663425; cv=none; b=b5W/DZyaAz9/x2bbER06lEZ4GblngGHbDiIfv2FpShr6rhUxRvnoLxieDPoasjeUPQZJEYXZWovJLdu9BA5syI4uqCD2uIMZXGBI1SY5WAH6W3xNulZb4VnZJwbJa3j4zlZZV3OZRCmrGx28cU+EY/3pdn3OjEmwGAf7grgOdA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768663425; c=relaxed/simple;
	bh=5KwaYynedZX2hmAgLdQ4q8bgxOY9EVpgGEoC/w/5Nn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7FjicS0PqOZLY3VM+0uYpbKBz2cG2KwIiIB47SVreBFDRE/+lPDLKChZC7NJ3jCi2fS2e4xqCMFHR0AahpxQNFQOrfxNOqKzjVFx5/OkIJza+Io1+C8vq8NRLJ/4T2ptbIgmoJ8IJ7G6Rhi7rDUPZlnBxQs6yJk7kTCEbvFE3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ah4ykgAd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0mBxI9aIz+3R0JRKzaZEq+nxJIFr2t+OaDEqZ+gvIxk=; b=ah4ykgAdIIK79zCcIQJbdM2aOJ
	tePiTgFGApdW0Nsy3G2R6mcTarWqh90tpWya2uswpGJVS/7YJz17ku6vGZgB3UZLSW/J/IWwulgiz
	hVbDlGW2qzyGeSCn8kmC287xaP1is0utSdnbz+Dvg6uNckRApwIGJ1Rcj4zEbqXmPhgI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vh89D-003DWR-KH; Sat, 17 Jan 2026 16:23:31 +0100
Date: Sat, 17 Jan 2026 16:23:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] spi: dt-bindings: xilinx: make interrupts optional
Message-ID: <f48aea5e-b600-4546-9bc6-82751cf4fe97@lunn.ch>
References: <20260117012136.265220-1-abdurrahman@nexthop.ai>
 <20260117012136.265220-4-abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117012136.265220-4-abdurrahman@nexthop.ai>

On Sat, Jan 17, 2026 at 01:21:36AM +0000, Abdurrahman Hussain wrote:
> This makes the driver work on platforms where interrupts are either not
> provided or broken.

In addition to Krzysztof comment, please do try to read all the links
to documents i sent you.

Point 5 of the binding document says:

    The Documentation/ portion of the patch should come in the series
    before the code implementing the binding.

This might sound nit picky, but there is a huge volume of patches
which need reviewing, and in order to make that possible we have
processes to make it simpler to do. Please keep to the processes,
particularly if you plan to stick around and become a regular
contributor.

    Andrew

---
pw-bot: cr

