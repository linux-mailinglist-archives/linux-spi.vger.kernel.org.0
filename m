Return-Path: <linux-spi+bounces-10491-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 512C8BC911A
	for <lists+linux-spi@lfdr.de>; Thu, 09 Oct 2025 14:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A00A19E60B8
	for <lists+linux-spi@lfdr.de>; Thu,  9 Oct 2025 12:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9042E2845;
	Thu,  9 Oct 2025 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8UQjOrD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AAC2DC346;
	Thu,  9 Oct 2025 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013542; cv=none; b=fpGS+okPQEFks2Q13tzHH118s13I38MBMU9XWqfXKJjDBuLTglvYZcg28prm6B3QoEgDrgVpTog/S4MTctot3DewYB/SxmcSkG8gJfWa8CwqSFhy62uyRnhTosmlqnkqdpBWT7lKDeMCjeCuPPA79cOgjHGQHAgySwkUfiLeAQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013542; c=relaxed/simple;
	bh=nCBWCQaxhZrktABfUp1S7UxjtEc626ybANk2Wgzh3PY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bQ8TxkfzFHersz/qHEwTjwmAwT/BpJsq15ZwEFoWLA+w5pxrtRtU1ZxTXQCPRvEqLpEDVoncabksyzDefbyO1lZ2owv5bKNTaBoCW4VBGMSXVyu25MTqmWF9sy0yMl3D0Bf9x6HpsxJL/+6qpHmUHJxU5vI6CNGOfcVo/ALlaaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8UQjOrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C069CC4CEE7;
	Thu,  9 Oct 2025 12:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760013542;
	bh=nCBWCQaxhZrktABfUp1S7UxjtEc626ybANk2Wgzh3PY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=g8UQjOrDuh+uJpia5t3++o9Q9C+62GHBeFw1wpvEx4tssNFTmPz5hJHes/tlPQlZX
	 THOJyFI51pi45GkxW7juDhfeOKoS96lr8V8dEYIOfOFnDT3zGnLG/sjqDgaSjWFOBb
	 lfKK+bWYkeEyoh0MzEUGRYfCC8rYvBlj0ojxz09HSlxSTcGy4vVkFin/vzClbzpCYJ
	 0vmbRNg5MTL8s5DQDuP4+tdm7sOSGW3NsR9fGiCMoTBhgzGSENNzbrlD+Yvb8LKiHj
	 7GiKEsORGdPt9maGTV5y/c9l1/xXTVtUFTrjS1U1tTDrmfMixnc6xDqJ9K1sJ4+O7K
	 lYj0AEas4cS9A==
From: Lee Jones <lee@kernel.org>
To: linux-acpi@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
 netdev@vger.kernel.org, linux-spi@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Matthias Fend <matthias.fend@emfend.at>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Paul Elder <paul.elder@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
In-Reply-To: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
Subject: Re: (subset) [PATCH v2 00/16] Align availability checks on fwnode
 child node enumeration
Message-Id: <176001353550.2818310.2373416266769760233.b4-ty@kernel.org>
Date: Thu, 09 Oct 2025 13:38:55 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-b87af

On Wed, 24 Sep 2025 10:45:46 +0300, Sakari Ailus wrote:
> Historically the fwnode property API has enumerated only available device
> nodes on OF whereas on ACPI, also nodes that haven't been present in the
> system have been provided. Both OF and ACPI have similar concepts of node
> availbility, on OF it's the "status" property present on device nodes and
> on ACPI the _STA object evaluates to device present, enabled and
> functional bits, of which the present and functional bits are currently
> being used to determine whether to enumerate a device.
> 
> [...]

Applied, thanks!

[13/16] leds: Use fwnode_for_each_child_node() instead
        commit: 34dbf5b458193b120a4a00777f2045f40c3db974
[14/16] leds: Use fwnode_get_next_child_node() instead
        commit: 93ecfb549059e3c77da16364c0f6fbddb42b147b

--
Lee Jones [李琼斯]


