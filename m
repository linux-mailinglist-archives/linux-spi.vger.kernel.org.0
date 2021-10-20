Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4E3434314
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 03:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJTBsH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Oct 2021 21:48:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:35368 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhJTBsG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 19 Oct 2021 21:48:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="292131139"
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="292131139"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 18:45:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="662055500"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by orsmga005.jf.intel.com with ESMTP; 19 Oct 2021 18:45:50 -0700
Date:   Wed, 20 Oct 2021 09:39:19 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
Subject: Re: [PATCH 1/1] spi: altera: Change to dynamic allocation of spi id
Message-ID: <20211020013919.GA146243@yilunxu-OptiPlex-7050>
References: <20211019002401.24041-1-russell.h.weight@intel.com>
 <278aa054-9710-440e-df6e-96c7b835e2ab@intel.com>
 <YW9qpi2Pu49emDXg@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW9qpi2Pu49emDXg@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Oct 20, 2021 at 02:02:30AM +0100, Mark Brown wrote:
> On Mon, Oct 18, 2021 at 05:27:38PM -0700, Russ Weight wrote:
> 
> > If there are no concerns with this patch, it will need to have the "cc stable"
> > tag added for earlier kernels.
> 
> This feels like a risky change to introduce into stable kernels
> given that while people shouldn't rely on stable number
> assignment they may well have done so.  I'll skip the stable tag
> though if you want to request a backport with the stable team
> they might be OK with it - it definitely feels like it should
> have a discussion rather than just going in with a tag.

It makes sense. Just skip my stable tag comment.

Thanks,
Yilun
