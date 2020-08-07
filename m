Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E8723EE66
	for <lists+linux-spi@lfdr.de>; Fri,  7 Aug 2020 15:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgHGNna (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Aug 2020 09:43:30 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:63780 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726282AbgHGNn1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Aug 2020 09:43:27 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077Dax9v009897;
        Fri, 7 Aug 2020 15:42:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=STMicroelectronics;
 bh=yrH1sOj/tTHQBQooVD/Sbc7bjAl/F6ZnmtA5MxyZscw=;
 b=1TXy3bfK6Radyo6qP7mwfBoiv4mSCFlK9wAjuGFdzpWQwBC7TzyDgX1uwWiWLdkFb8Ua
 UZPhX/C7tQyoxVLuhUMj/d/trbpXar5qlSRnFG/u4OSOx7P9XI/ObcCPspOozBJ9ctRK
 ffvFkUQ9mgVLdAlU2dQQ7Ae7plM8B73omFpdHZC/FJ7DDKHTYQ0xnH9aZhqBXPBeecTJ
 qZoubeEuB67smJsqXzLTJDTNI/XJ6Gw/kWZwYHcRlwGVKp9jl/bbyI6Yzb3XHDs0wBo/
 nWTegWxkb11c/LPIw7l+3ov+MXKTTxyyf/qFEzNQH4YRhvhVU5DlzipmZWKjsMcG7ATE hA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6sbj1cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 15:42:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7965310002A;
        Fri,  7 Aug 2020 15:42:56 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 662972B35EB;
        Fri,  7 Aug 2020 15:42:56 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Aug
 2020 15:42:55 +0200
Date:   Fri, 7 Aug 2020 15:42:54 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <amelie.delaunay@st.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>
Subject: Re: [PATCH 02/18] spi: stm32-spi: defer probe for reset
Message-ID: <20200807134254.GC12946@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Mark Brown <broonie@kernel.org>, amelie.delaunay@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
 <1596610933-32599-3-git-send-email-alain.volmat@st.com>
 <20200805104906.GB5556@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200805104906.GB5556@sirena.org.uk>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_09:2020-08-06,2020-08-07 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 05, 2020 at 11:49:06AM +0100, Mark Brown wrote:
> On Wed, Aug 05, 2020 at 09:01:57AM +0200, Alain Volmat wrote:
> 
> > -	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> > -	if (!IS_ERR(rst)) {
> > +	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
> > +	if (rst) {
> > +		if (IS_ERR(rst)) {
> > +			ret = PTR_ERR(rst);
> > +			if (ret != -EPROBE_DEFER)
> > +				dev_err(&pdev->dev, "reset get failed: %d\n",
> > +					ret);
> > +			goto err_clk_disable;
> > +		}
> 
> This will not provide any diagnostics when deferring which isn't very
> helpful if there's issues.

Do you mean that a message when deferring would be needed ?

I am worrying that this would lead to having too much noise during boot
since probe deferring is kinda common. Of course it can also be due to a bad
configuration of the kernel as well but having looked around I think that
usually driver are rather silent in case of deferring.
