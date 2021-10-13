Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C80842BB08
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 11:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbhJMJD7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 05:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbhJMJD6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Oct 2021 05:03:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78EFA610A1;
        Wed, 13 Oct 2021 09:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634115715;
        bh=jN/4FAaN7crTTlDuot+9D29of9NN4is61FaPC7nYdAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L5Gn6sSPZHVB588QFAb+aGM67vjlUeequD5fC5h/Fs6v6wdKC/kTv7i3IGPeRtKr2
         aGu86AWA424KGny9HsUqy4omNpd3CFLdwfl450O3W0Tz42aNFl65DHtLfFtGHD9kM5
         rbtJCG0xpY3dhsyaLdlB0lVR4CbWXjBkRkmhlf54=
Date:   Wed, 13 Oct 2021 11:01:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        Mark Gross <mgross@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 12/20] misc: lis3lv02d: Make lis3lv02d_remove_fs()
 return void
Message-ID: <YWaggVCzL/CoVLa6@kroah.com>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
 <20211012153945.2651412-13-u.kleine-koenig@pengutronix.de>
 <bc739810-abb4-d7bc-e901-227b43bc5a71@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc739810-abb4-d7bc-e901-227b43bc5a71@redhat.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Oct 12, 2021 at 05:54:46PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 10/12/21 5:39 PM, Uwe Kleine-König wrote:
> > Up to now lis3lv02d_remove_fs() returns zero unconditionally. Make it return
> > void instead which makes it easier to see in the callers that there is
> > no error to handle.
> > 
> > Also the return value of i2c and spi remove callbacks is ignored anyway.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Also please consider this as my ack for merging the
> drivers/platform/x86/ part of this through whatever
> tree is convenient.

Thanks, I'll take it!

greg k-h
