Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11EF403A74
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 15:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347289AbhIHNTD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 09:19:03 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:39466 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235294AbhIHNTD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 09:19:03 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188Bs77B012895;
        Wed, 8 Sep 2021 08:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=fBDzz+PZ7Z+6aq21w/ER1P5vDyTBMboJ7PkG9Vnwhm0=;
 b=qHezBhbgqDNw7ZY6Hbwd8chsH3yF2Ck6xgM2XmJszU+26KSDKEDJ/q8huWI09NP+Q8F+
 TS/hKuFg8lfE2F4ApukZb+buNkj+BdgSAmw1w14NmoQVDbvGa3HjXT70xnjp0fk7J/AC
 7s98EJLwjVv9wC4akb+LaVJBLT0apa4q96pya4fbKu+kLg61n0+CKzV6X3xhRixnB5w8
 VYcBJFIkcViXO7JSqp3SHA2OknxnHrIMeSh6vz5ZTkNBD+mAPpeqQq8b5Fqtlz9hNtym
 M48lXzcrAlzHlK/FJZ+UlijYoR+yv5j/oonOt9o5MBxbXjMvp1J7bzIGJ/p1gvK2AtJ6 Tg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3axcp61m9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 08:17:51 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 8 Sep
 2021 14:17:46 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 8 Sep 2021 14:17:46 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 61F59B16;
        Wed,  8 Sep 2021 13:17:45 +0000 (UTC)
Date:   Wed, 8 Sep 2021 13:17:45 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 02/10] regmap: spi: Check raw_[read|write] against max
 message size
Message-ID: <20210908131745.GQ9223@ediswmail.ad.cirrus.com>
References: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
 <20210908113450.788452-3-tanureal@opensource.cirrus.com>
 <20210908130929.GP9223@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210908130929.GP9223@ediswmail.ad.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: K4E6xdiFCSO9DLnYdR1ReLqyEszvDITQ
X-Proofpoint-GUID: K4E6xdiFCSO9DLnYdR1ReLqyEszvDITQ
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Sep 08, 2021 at 01:09:29PM +0000, Charles Keepax wrote:
> On Wed, Sep 08, 2021 at 12:34:43PM +0100, Lucas Tanure wrote:
> > regmap-spi will split data and address between two transfers
> > in the same message, so max_[read|write] must include space
> > for the address and padding
> > 
> > Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> > ---
> >  drivers/base/regmap/regmap-spi.c |  4 ++++
> >  drivers/base/regmap/regmap.c     | 15 +++++++++++++++
> >  include/linux/regmap.h           |  3 +++
> >  3 files changed, 22 insertions(+)
> > 
> > diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
> > index 0e6552e57ecf..1434c502e340 100644
> > --- a/drivers/base/regmap/regmap-spi.c
> > +++ b/drivers/base/regmap/regmap-spi.c
> > @@ -123,6 +123,10 @@ static const struct regmap_bus *regmap_get_spi_bus(struct spi_device *spi,
> >  		bus->free_on_exit = true;
> >  		bus->max_raw_read = max_size;
> >  		bus->max_raw_write = max_size;
> > +
> > +		if (spi_max_message_size(spi) != SIZE_MAX)
> > +			bus->max_combined_rw = spi_max_message_size(spi);
> 
> I am not sure max_combined_rw is the best name here, it makes
> sense in a SPI context where reads are a write followed by a
> read. But does it really make sense for all buses? Like an MMIO
> this no longer seems a very meaningful name.
> 
> Perhaps max_transaction? But I am often not the best at thinking
> of names myself.
> 

Although thinking about this more are we sure this wouldn't just
be better as a flag to include the address in the max_raw_read/write?
I am not sure what extra use-cases the extra max_combined_rw
opens up and it feels like the field is doing two things, 1)
saying that the address needs to be included in the max size and
2) specifying a new max size.

Thanks,
Charles
