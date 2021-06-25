Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0713B438E
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jun 2021 14:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhFYMs6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Jun 2021 08:48:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33560 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229470AbhFYMs5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Jun 2021 08:48:57 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PCjwxx009152;
        Fri, 25 Jun 2021 12:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=OZcLDZpJSbiJrxXQXQGe20xrTG0YjwZ5YOFjZSQ+y00=;
 b=0DkYahLH+dNK9senydET2YjIKDDzdaeri/SVKtM9OEHVUO8XrphI47bcYwQRT7NOrNW4
 NkGQJDoJ23p09UT6h7tL+blhp7layTNImofGxvPsmH+9bmRk5rMVT3Vslf2ZP3wAIz6c
 GDsSPPsZjhKEyCdqdwkvXp4jUaaRPwb02pz4qMNg0duVIToSnQYYOcL/H42nVXatqbOn
 KZmfxISvygsRZuqPuxZrJyHGUh5+FsNbXQgtA3RE2EjWUILU4JSWcMFnBv89AKZlEmpS
 1rizS78pD/9KzgnkwW8AmiKuIbls7yURevgKDXpi6Xaq/XGfGWY0glJTuDc0GEQmDNQH 3A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d2kxs7p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 12:46:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15PCjPX6165774;
        Fri, 25 Jun 2021 12:46:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 39dbb1baby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 12:46:28 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15PCkRRM169327;
        Fri, 25 Jun 2021 12:46:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 39dbb1babb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 12:46:27 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.14.4) with ESMTP id 15PCkOWU010483;
        Fri, 25 Jun 2021 12:46:24 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jun 2021 05:46:23 -0700
Date:   Fri, 25 Jun 2021 15:46:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, lijian_8010a29@163.com, broonie@kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lijian <lijian@yulong.com>
Subject: Re: [PATCH] spi: spi-topcliff-pch: Fixed the possible null pointer
 exception issue
Message-ID: <202106250844.rdb0bMCH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624105056.167233-1-lijian_8010a29@163.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: 99jWMH0Qo0iXqKpAx99mbHlqXqwXUamX
X-Proofpoint-ORIG-GUID: 99jWMH0Qo0iXqKpAx99mbHlqXqwXUamX
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

url:    https://github.com/0day-ci/linux/commits/lijian_8010a29-163-com/spi-spi-topcliff-pch-Fixed-the-possible-null-pointer-exception-issue/20210624-185333
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: i386-randconfig-m021-20210622 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/spi/spi-topcliff-pch.c:632 pch_spi_set_tx() error: uninitialized symbol 'j'.

Old smatch warnings:
drivers/spi/spi-topcliff-pch.c:1253 pch_spi_process_messages() warn: variable dereferenced before check 'data->cur_trans' (see line 1201)

vim +/j +632 drivers/spi/spi-topcliff-pch.c

c37f3c2749b5322 drivers/spi/spi-topcliff-pch.c Tomoya MORINAGA 2011-06-07  544  static void pch_spi_set_tx(struct pch_spi_data *data, int *bpw)
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  545  {
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  546  	int size;
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  547  	u32 n_writes;
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  548  	int j;
cd8d984f0def2a8 drivers/spi/spi-topcliff-pch.c Wei Yongjun     2013-04-27  549  	struct spi_message *pmsg, *tmp;
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  550  	const u8 *tx_buf;
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  551  	const u16 *tx_sbuf;
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  552  
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  553  	/* set baud rate if needed */
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  554  	if (data->cur_trans->speed_hz) {
65308c46b760bb2 drivers/spi/spi_topcliff_pch.c Grant Likely    2010-09-29  555  		dev_dbg(&data->master->dev, "%s:setting baud rate\n", __func__);
65308c46b760bb2 drivers/spi/spi_topcliff_pch.c Grant Likely    2010-09-29  556  		pch_spi_set_baud_rate(data->master, data->cur_trans->speed_hz);
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  557  	}
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  558  
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  559  	/* set bits per word if needed */
65308c46b760bb2 drivers/spi/spi_topcliff_pch.c Grant Likely    2010-09-29  560  	if (data->cur_trans->bits_per_word &&
65308c46b760bb2 drivers/spi/spi_topcliff_pch.c Grant Likely    2010-09-29  561  	    (data->current_msg->spi->bits_per_word != data->cur_trans->bits_per_word)) {
65308c46b760bb2 drivers/spi/spi_topcliff_pch.c Grant Likely    2010-09-29  562  		dev_dbg(&data->master->dev, "%s:set bits per word\n", __func__);
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  563  		pch_spi_set_bits_per_word(data->master,
65308c46b760bb2 drivers/spi/spi_topcliff_pch.c Grant Likely    2010-09-29  564  					  data->cur_trans->bits_per_word);
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  565  		*bpw = data->cur_trans->bits_per_word;
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  566  	} else {
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  567  		*bpw = data->current_msg->spi->bits_per_word;
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  568  	}
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  569  
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  570  	/* reset Tx/Rx index */
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  571  	data->tx_index = 0;
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  572  	data->rx_index = 0;
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  573  
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  574  	data->bpw_len = data->cur_trans->len / (*bpw / 8);
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  575  
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  576  	/* find alloc size */
65308c46b760bb2 drivers/spi/spi_topcliff_pch.c Grant Likely    2010-09-29  577  	size = data->cur_trans->len * sizeof(*data->pkt_tx_buff);
65308c46b760bb2 drivers/spi/spi_topcliff_pch.c Grant Likely    2010-09-29  578  
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  579  	/* allocate memory for pkt_tx_buff & pkt_rx_buffer */
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  580  	data->pkt_tx_buff = kzalloc(size, GFP_KERNEL);
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  581  	if (data->pkt_tx_buff != NULL) {
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  582  		data->pkt_rx_buff = kzalloc(size, GFP_KERNEL);
026a1dc1af52742 drivers/spi/spi-topcliff-pch.c Jay Fang        2021-05-06  583  		if (!data->pkt_rx_buff) {
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  584  			kfree(data->pkt_tx_buff);
026a1dc1af52742 drivers/spi/spi-topcliff-pch.c Jay Fang        2021-05-06  585  			data->pkt_tx_buff = NULL;
026a1dc1af52742 drivers/spi/spi-topcliff-pch.c Jay Fang        2021-05-06  586  		}
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  587  	}
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  588  
65308c46b760bb2 drivers/spi/spi_topcliff_pch.c Grant Likely    2010-09-29  589  	if (!data->pkt_rx_buff) {
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  590  		/* flush queue and set status of all transfers to -ENOMEM */
cd8d984f0def2a8 drivers/spi/spi-topcliff-pch.c Wei Yongjun     2013-04-27  591  		list_for_each_entry_safe(pmsg, tmp, data->queue.next, queue) {
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  592  			pmsg->status = -ENOMEM;
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  593  
f5d8ee3f15dd718 drivers/spi/spi-topcliff-pch.c Sachin Kamat    2013-05-31  594  			if (pmsg->complete)
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  595  				pmsg->complete(pmsg->context);
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  596  
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  597  			/* delete from queue */
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  598  			list_del_init(&pmsg->queue);
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  599  		}
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  600  		return;
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  601  	}
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  602  
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  603  	/* copy Tx Data */
393b49835a2b7cf drivers/spi/spi-topcliff-pch.c lijian          2021-06-24  604  	if ((data->cur_trans->tx_buf != NULL) && (data->pkt_tx_buff != NULL)) {
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  605  		if (*bpw == 8) {
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  606  			tx_buf = data->cur_trans->tx_buf;
65308c46b760bb2 drivers/spi/spi_topcliff_pch.c Grant Likely    2010-09-29  607  			for (j = 0; j < data->bpw_len; j++)
65308c46b760bb2 drivers/spi/spi_topcliff_pch.c Grant Likely    2010-09-29  608  				data->pkt_tx_buff[j] = *tx_buf++;
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  609  		} else {
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  610  			tx_sbuf = data->cur_trans->tx_buf;
65308c46b760bb2 drivers/spi/spi_topcliff_pch.c Grant Likely    2010-09-29  611  			for (j = 0; j < data->bpw_len; j++)
65308c46b760bb2 drivers/spi/spi_topcliff_pch.c Grant Likely    2010-09-29  612  				data->pkt_tx_buff[j] = *tx_sbuf++;
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  613  		}
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  614  	}
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  615  
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  616  	/* if len greater than PCH_MAX_FIFO_DEPTH, write 16,else len bytes */
65308c46b760bb2 drivers/spi/spi_topcliff_pch.c Grant Likely    2010-09-29  617  	n_writes = data->bpw_len;
65308c46b760bb2 drivers/spi/spi_topcliff_pch.c Grant Likely    2010-09-29  618  	if (n_writes > PCH_MAX_FIFO_DEPTH)
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  619  		n_writes = PCH_MAX_FIFO_DEPTH;
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  620  
b996356d305fd31 drivers/spi/spi-topcliff-pch.c Markus Elfring  2017-01-13  621  	dev_dbg(&data->master->dev,
b996356d305fd31 drivers/spi/spi-topcliff-pch.c Markus Elfring  2017-01-13  622  		"\n%s:Pulling down SSN low - writing 0x2 to SSNXCR\n",
b996356d305fd31 drivers/spi/spi-topcliff-pch.c Markus Elfring  2017-01-13  623  		__func__);
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  624  	pch_spi_writereg(data->master, PCH_SSNXCR, SSN_LOW);
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  625  
393b49835a2b7cf drivers/spi/spi-topcliff-pch.c lijian          2021-06-24  626  	if (data->pkt_tx_buff != NULL) {
65308c46b760bb2 drivers/spi/spi_topcliff_pch.c Grant Likely    2010-09-29  627  		for (j = 0; j < n_writes; j++)
65308c46b760bb2 drivers/spi/spi_topcliff_pch.c Grant Likely    2010-09-29  628  			pch_spi_writereg(data->master, PCH_SPDWR, data->pkt_tx_buff[j]);
393b49835a2b7cf drivers/spi/spi-topcliff-pch.c lijian          2021-06-24  629  	}

"j" not initialized on else path.

e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  630  
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  631  	/* update tx_index */
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08 @632  	data->tx_index = j;
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  633  
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  634  	/* reset transfer complete flag */
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  635  	data->transfer_complete = false;
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  636  	data->transfer_active = true;
e8b17b5b3f30252 drivers/spi/spi_topcliff_pch.c Masayuki Ohtake 2010-10-08  637  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

