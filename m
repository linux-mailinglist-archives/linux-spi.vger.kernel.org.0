Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A5044FF37
	for <lists+linux-spi@lfdr.de>; Mon, 15 Nov 2021 08:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhKOHc2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 02:32:28 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:62328 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhKOHc1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Nov 2021 02:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636961372; x=1668497372;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7sQasIPCe907PukyO0HlLZLCVQTkoCibmM7U7+05lJo=;
  b=cH5ENvYRdjsIv+WQPrFIvaUI8+M6y7reEN9wiXbE5WyE6lz1RJ6UMuZF
   Ny/75jdqzeHTzl88fRKct4OnnB53rVFZPZp4XfSQpOHXN9zILKPGaLT7d
   B/nVP35rOa/hFYb26siIWW1wm+tsqERl60GHlkQLQROd9fqQ4EwVN6o6X
   s2Ntw2An6gBoxgBp+/mgNkdtx14+eHNrEyXPBjlHGI7FuI+5fNg6oy4fH
   s2gymMKb5kksCqkYOycFOItmVLGraUhCAPoTm17d48v9XOdI8wBwmws/r
   cHtNgw/gsrJutB/enWYDW8VvrBOR5SrUAL7h4ivY2zp2c35Jnw2O88t6s
   A==;
X-IronPort-AV: E=Sophos;i="5.87,235,1631570400"; 
   d="scan'208";a="20456675"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 15 Nov 2021 08:29:31 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 15 Nov 2021 08:29:31 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 15 Nov 2021 08:29:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636961371; x=1668497371;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7sQasIPCe907PukyO0HlLZLCVQTkoCibmM7U7+05lJo=;
  b=MvenPcSYbQrqq4MwxDF8Ws8zNogBHJMeJUX5NcBoZGSIXSlrwL3rvAmK
   Ag5S+4CDDODY8gS6oWQr0JPAQrOPaGunytQh97MSANpkgscYYGcBGeBVT
   CXCue2YGoZ39/Fq1eFYaYu9IDDr5WKqCmuPYm9LFNOgcx0yd8x2cxBOCz
   E/GMsHNQ9mncxdopU05BDHuFOK1HWQuOUl4eJKvGfMa6LXazBz29+Qbl7
   cYDg5RWV1Zm068N2XLhILPztbOJCIMBoaWAZbi7L7y8NH50/zccOkF/EX
   26cN619CKqKi9LPxZQT5dg+fIJ147gfdNM+L3S2M3sW/3m187r3hmFU9U
   w==;
X-IronPort-AV: E=Sophos;i="5.87,235,1631570400"; 
   d="scan'208";a="20456674"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Nov 2021 08:29:31 +0100
Received: from steina-w (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 51257280065;
        Mon, 15 Nov 2021 08:29:31 +0100 (CET)
Message-ID: <f1ff86b1bd29ff3c3985046f0956ac1d441c2b7a.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH 1/1] spi: lpspi: release requested DMA channels
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Date:   Mon, 15 Nov 2021 08:29:29 +0100
In-Reply-To: <YY6vyLt6lhUp8xXW@sirena.org.uk>
References: <20211109103134.184216-1-alexander.stein@ew.tq-group.com>
         <YY6vyLt6lhUp8xXW@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

Am Freitag, dem 12.11.2021 um 18:17 +0000 schrieb Mark Brown:
> * PGP Signed by an unknown key
> 
> On Tue, Nov 09, 2021 at 11:31:34AM +0100, Alexander Stein wrote:
> > The requested DMA channels are never released. Do this in .remove as well
> > as in .probe. spi_register_controller() can return -EPROBE_DEFER if
> > cs-gpios are not probed yet.
> 
> This doesn't apply against current code, please check and resend.

I just noticed there is a dependency to the other patch I sent as well
and which got accepted in commit 12f62a857c83 ("spi: lpspi: Silence
error message upon deferred probe") meanwhile.
I rebased this patch locally to next-20211115 and the newly formatted
patch file is identical to 100%. It should apply now. I can resend it
if you insist, but it is not necessary IMHO.

Best regards,
Alexander


