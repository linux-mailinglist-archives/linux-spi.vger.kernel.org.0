Return-Path: <linux-spi+bounces-4232-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D329573B9
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 20:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CFE72853C4
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937C318A6D1;
	Mon, 19 Aug 2024 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnLOlXXQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C10A189F5C;
	Mon, 19 Aug 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092773; cv=none; b=slmOMJz9dOasRAC6EVOjRxk442KX1eL84XyJxT4zroGTkqDzgIe+VP2FB5ikucoMqMh3QBpIIBLNUATrKK3EhcpVQ2PDaTQkqW647pIX5uo0YbQ42fillhj7li3oCNHpc6l69MptR/ENmWaGMzPTs4tdqR6JnJSlv/V8JY8KV2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092773; c=relaxed/simple;
	bh=k86tyyWPNxb3mEa0tZJ3W2yt7c06vg3dCTcq4c4U4Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9ru+qTJ00j5udC2QjsQH359evLhqBs310WkRYHSXnUACKe56USzH9TWODKeoMOIZyLQ3ohyOZ4Thwq1D7i0UjBs4mMnN0DNeOV2JUKLXN5V9xJiZSQtfWnEoJ0zCkyYUYa01lgzuGQfBHvvgcRLHyZ+yo0PkVuApW0qSXXXbPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnLOlXXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE3BC32782;
	Mon, 19 Aug 2024 18:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724092770;
	bh=k86tyyWPNxb3mEa0tZJ3W2yt7c06vg3dCTcq4c4U4Iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnLOlXXQpgxGLtbXzxnoFFia7QabXbpNQPox/0Lui0O5jlxIfbcmBmc9hacCt2+J9
	 e3MDwSqUJKMIhtCPSq9gf242GlOxSSDkXBL7AlRI56nzp4rRZiIRqoSWNeQkuJT/Z5
	 CKBIJArLxWXMBtIL70BbkTln14F/y4YVmS3DypE1Ex6mF1ZppofU5oUMbfanBlh+MD
	 9+twmBiXeNfwAYvbxL8I6/9TH2vW9vzRV9f53VOGDeE9//wVwZruSitqytb9Cnwb16
	 d6OFh7FND0olRE2UGVwnMDrI7kA89pvCoQfawmwaKuOA09qCqtYlSmSSclb2e3Sd2Z
	 LCTvrOwrfhyNA==
Date: Mon, 19 Aug 2024 20:39:26 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: broonie@kernel.org, krzk@kernel.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] spi: s3c64xx: Fix module autoloading
Message-ID: <27tqmeu4mdxcp2ochrjkdxv3zu3fuxdjysxzql3xtrh27zgsok@t5i5zrnb7j72>
References: <20240819040523.2801461-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819040523.2801461-1-ruanjinjie@huawei.com>

Hi Jinjie,

On Mon, Aug 19, 2024 at 12:05:23PM GMT, Jinjie Ruan wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi

