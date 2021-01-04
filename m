Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EE62E8F21
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 02:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbhADBCz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 3 Jan 2021 20:02:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:20452 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbhADBCz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 3 Jan 2021 20:02:55 -0500
IronPort-SDR: k2oE00TtrAR43YOSAbkckNgXjxxHg3aptFT5Qb0zyUd+FKHd9lOaVy5Pg2/MWs4SBL+elulGVB
 htpwAe+LigQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9853"; a="164601975"
X-IronPort-AV: E=Sophos;i="5.78,472,1599548400"; 
   d="scan'208";a="164601975"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2021 17:02:15 -0800
IronPort-SDR: sH8gU3O2rlIm9+0YZpkmnWl1Q89iMOi9CKRHmDtmsYNjPtcpqeeyj2ERf70Eu3d+qLl1jM80V3
 w5cNW2f4w0fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,472,1599548400"; 
   d="scan'208";a="378205379"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga008.jf.intel.com with ESMTP; 03 Jan 2021 17:02:12 -0800
Date:   Mon, 4 Jan 2021 08:57:32 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] spi: fix the divide by 0 error when calculating xfer
  waiting time
Message-ID: <20210104005731.GH14854@yilunxu-OptiPlex-7050>
References: <1609556386-19422-1-git-send-email-yilun.xu@intel.com>
 <CAOMZO5AnaiDhR_PpGtyeneE_49=imOgawZTObxb7i0ibcfkKtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5AnaiDhR_PpGtyeneE_49=imOgawZTObxb7i0ibcfkKtQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Jan 02, 2021 at 11:11:14AM -0300, Fabio Estevam wrote:
> On Sat, Jan 2, 2021 at 12:07 AM Xu Yilun <yilun.xu@intel.com> wrote:
> >
> > The xfer waiting time is the result of xfer->len / xfer->speed_hz. This
> > patch makes the assumption of 1khz xfer speed if the xfer->speed_hz is
> 
> You missed to update the commit log to 100kHz.

Thanks for the catching, I'll fix it.

Yilun
